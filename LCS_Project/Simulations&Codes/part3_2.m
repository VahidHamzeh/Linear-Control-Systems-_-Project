clc; clear; close all;

numG = [1 0 3000];
denG = [300 7000 1005000 3000000 45000000]; %

n = 100;
kp_range = linspace(1500, 1700, n); 
ki_range = linspace(18000, 22000, n);

best_ts = inf;
best_kp = NaN; 
best_ki = NaN;
min_overshoot = inf;

tic;

for i = 1:n
    Kp = kp_range(i);
    for j = 1:n
        Ki = ki_range(j);
        
        % تشکیل مخرج کسر حلقه بسته
        den_cl = [denG 0] + [0 0 Kp Ki 0 0] + [0 0 0 0 3000*Kp 3000*Ki];
        
        % بررسی پایداری
        if all(den_cl > 0)
            p = roots(den_cl);
            if all(real(p) < 0)
                % تشکیل تابع تبدیل برای بررسی دقیق
                sys_cl = tf([Kp Ki 3000*Kp 3000*Ki], den_cl);
                info = stepinfo(sys_cl, 'SettlingTimeThreshold', 0.1, 'RiseTimeLimits', [0.1 0.9]);                
                % معیار انتخاب: اولویت با رعایت Overshoot و سپس کمترین Ts
                if info.Overshoot <= 10
                    if info.SettlingTime < best_ts
                        best_ts = info.SettlingTime;
                        best_kp = Kp;
                        best_ki = Ki;
                        actual_os = info.Overshoot;
                    end
                end
            end
        end
    end
    % نمایش وضعیت پیشرفت
    if mod(i, 200) == 0, fprintf('پیشرفت: %2.0f%%\n', (i/n)*100); end
end

toc;

if isnan(best_kp)
    error('هیچ جفتی از Kp و Ki با فراجهش زیر ۱۰٪ پیدا نشد. بازه جستجو را تغییر دهید.');
end

fprintf('\n--- نتایج بهینه نهایی ---\n');
fprintf('Best Kp: %.4f | Best Ki: %.4f\n', best_kp, best_ki);
fprintf('Settling Time (Ts): %.4f s | Overshoot: %.2f%%\n', best_ts, actual_os);

%% رسم پاسخ نهایی برای بهترین مقادیر
sys_final = feedback(pid(best_kp, best_ki)*tf(numG, denG), 1);
t = 0:0.005:10;
r = 0.1 * ones(size(t)); % مرجع 0.1 متر
[y, t_out] = lsim(sys_final, r, t);

figure('Color', 'w');
plot(t_out, y, 'b', 'LineWidth', 2); hold on;
plot(t_out, r, 'r--', 'LineWidth', 1.5);
grid on; 
title(['بهترین پاسخ: Kp=', num2str(best_kp), ' Ki=', num2str(best_ki)]);
xlabel('Time (s)'); ylabel('x_1 (m)');
legend('Response x_1', 'Reference 0.1m');