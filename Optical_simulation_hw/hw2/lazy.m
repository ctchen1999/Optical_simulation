clc; clear; close all;
%%
% % face
t = -pi:0.01:pi;
x = 0 + 5*cos(t);
y = 0 + 7.5*sin(t);
face = fill(x, y, [0.9764, 0.9529, 0.8784]);
xlim([-7.5 7.5])
% set(gcf, 'Position', [1000 500 650 500])
axis equal
hold on

% % eyes
% x_eye_left = -2.1 + 1.*cos(t);
% y_eye_left = 1.5 + .75.*sin(t);
% fill(x_eye_left, y_eye_left, [1 1 1])
% x_eye_right = 2.1 + 1.*cos(t);
% y_eye_right = 1.5 + .75.*sin(t);
% fill(x_eye_right, y_eye_right, [1 1 1])
% x_eye = -2.1 + 0.5*sin(t);
% y_eye = 1.5 + 0.75*cos(t);
% fill(x_eye, y_eye, [0 0 0]);
% x_eye = 2.1 + 0.5*sin(t);
% y_eye = 1.5 + 0.75*cos(t);
% fill(x_eye, y_eye, [0 0 0]);

% % glasses
% x_glasses_left = [-3.8 -2.1 -0.5];
% y_glasses_left = [2 2.7 2];
% xi_glasses = -3.8:0.01:-0.5;
% glasses_left1 = interp1(x_glasses_left, y_glasses_left, xi_glasses, 'spline');
% plot(xi_glasses, glasses_left1,'k');
% 
% x_glasses_left = [-3.8 -3.2 -2.1 -1 -0.5];
% y_glasses_left = [2 0 -1 0 2];
% xi_glasses = -3.8:0.01:-0.5;
% glasses_left2 = interp1(x_glasses_left, y_glasses_left, xi_glasses, 'spline');
% plot(xi_glasses, glasses_left2,'k');
% 
% x_glasses_right = [3.8 2.1 0.5];
% y_glasses_right = [2 2.7 2];
% xi_glasses = 3.8:-0.01:0.5;
% glasses_right1 = interp1(x_glasses_right, y_glasses_right, xi_glasses, 'spline');
% plot(xi_glasses, glasses_right1,'k');
% 
% x_glasses_right = [3.8 3.2 2.1 1 0.5];
% y_glasses_right = [2 0 -1 0 2];
% xi_glasses = 3.8:-0.01:0.5;
% glasses_right2 = interp1(x_glasses_right, y_glasses_right, xi_glasses, 'spline');
% plot(xi_glasses, glasses_right2,'k');
% 
% %眼鏡中的連線
% x = [-0.8 0 0.8];
% y = [1.5  1 1.5];
% xi = -0.8:0.01:0.8;
% y = interp1(x,y,xi,'spline');
% plot(xi,y,'k');
% %眼鏡旁的連線
% l1 =line([-3.56 -4.8],[1.02 2.6]);
% l2 = line([3.56 4.8],[1.02 2.6]);
% set(l1,'Color','k');
% set(l2,'Color','k');
% % ear
% polygon_left_ear = polyshape([-4.8 -5  -5.2  -5.4  -5.6  -5.8 -6  -5.6 -5], ...
%                              [ 2.6 2.9    3  3.07  3.15  3.07 2.5 0.8  -1]);
% plot(polygon_left_ear, 'FaceColor', [0.9764, 0.9529, 0.8784]);
% polygon_right_ear = polyshape([4.8   5  5.2  5.4   5.6   5.8   6  5.6   5], ...
%                              [ 2.6 2.9    3  3.07  3.15  3.07 2.5 0.8  -1]);
% plot(polygon_right_ear, 'FaceColor', [0.9764, 0.9529, 0.8784]);
% 
% % eyebrows
% eyebrow_left = polyshape([-1.2 -3.5 -3.6  -1.2], ...
%                          [3.75  4.5  4.2  3.45]);
% plot(eyebrow_left, 'FaceColor',[0 0 0]);
% eyebrow_right = polyshape([1.2   3.5  3.6   1.2], ...
%                           [3.75  4.5  4.2  3.45]);
% plot(eyebrow_right, 'FaceColor',[0 0 0]);
% 
% % nose 
% % nose_left = line([], []);
% nose_left  = plot([-0.4 -0.45 -0.6 -0.7 -0.8 -0.85  -0.9], ...
%                   [   1    0   -1   -2   -3    -4   -4.5], 'color',[0 0 0]);
% nose_right = plot([ 0.4  0.45  0.6  0.7  0.8  0.85   0.9], ...
%                   [   1    0   -1   -2   -3    -4   -4.5], 'color',[0 0 0]);
% % mouth
% plot([-1.25 1.25], [-7 -7], 'Color',[0 0 0]);
% 
% mx_up = [-1.25 -0.5 0 0.5 1.25];
% my_up = [-7 -6 -6.25 -6 -7];
% mxi_up = -1.25:0.01:1.25;
% y_up = interp1(mx_up, my_up, mxi_up, 'Spline');
% plot(mxi_up, y_up, 'Color', [0 0 0]);
% fill(mxi_up,y_up,[0.8392 0.6588 0.5647]);
% 
% mx_down = [-1.25 0 1.25];
% my_down = [-7 -8 -7];
% mxi_down = -1.25:0.01:1.25;
% y_down = interp1(mx_down, my_down, mxi_down, 'Spline');
% plot(mxi_down, y_down, 'Color', [0 0 0]);
% fill(mxi_down,y_down, [0.8392 0.6588 0.5647]);
% 
% % hat
% % hat
% hx1 = [-4.2  0   4.2];
% hy1 = [6.2  5.5  6.2];
% hxi1 = -4.2:0.01:4.2;
% y1 = interp1(hx1, hy1, hxi1, 'Spline');
% fill(hxi1,y1,'k');
% plot(hxi1, y1, 'Color', 'k','LineWidth',24);
% 
% 
% hx2 = [-4.2   0   4.2];
% hy2 = [7.2   6.5  7.2];
% hxi2 = -4.2:0.01:4.2;
% y2 = interp1(hx2, hy2, hxi2, 'Spline');
% plot(hxi2, y2, 'Color', [1 1 1])
% 
% hx3 = [-4 -2 0 2 4];
% hy3 = [6.2 9.1 10 9.1 6.2];
% hxi3 = -4:0.01:4;
% y3 = interp1(hx3, hy3, hxi3, 'spline');
% fill(hxi3, y3, 'k');
% title('My own face')
% hold off
% axis off