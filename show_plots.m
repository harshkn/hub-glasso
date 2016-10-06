tr_ed = out.total_true_edges;
save_plot = 0;
cs1 = res{1};
cs2 = res{2};
cs3 = res{3};
xlval = 6500;
% cs1 = cs1(3:9,:);
% cs2 = cs2(3:9,:);
% cs3 = cs3(3:9,:);
[valBIC1, idxBIC1] = min(cs1(:,9));
[valBIC2, idxBIC2] = min(cs2(:,9));
[valBIC3, idxBIC3] = min(cs3(:,9));
figure(1)
hold on
plot(cs1(:,4),cs1(:,5),'r*-');
plot(cs2(:,4),cs2(:,5),'g*-');
plot(cs3(:,4),cs3(:,5),'b*-');
h = line([tr_ed,tr_ed],ylim);
set(h,'Color','magenta');
plot(cs1(idxBIC1,4),cs1(idxBIC1,5),'k.','MarkerSize', 20);
xlim([1 xlval]);
legend('lamba3 = 1','lamba3 = 2','lamba3 = 3', 'true edges', 'BIC for lam3 = 1');
xlabel('Num. Est Edges')
ylabel('Num Corr Est Edges');
if(save_plot == 1)
    print('-dpng', '-r300', 'p1.png') % for png
end

%%
figure(2)
hold on
plot(cs1(:,4),cs1(:,6),'r*-');
plot(cs2(:,4),cs2(:,6),'g*-');
plot(cs3(:,4),cs3(:,6),'b*-');
h = line([tr_ed,tr_ed],ylim);
set(h,'Color','magenta');
plot(cs1(idxBIC1,4),cs1(idxBIC1,6),'k.','MarkerSize', 20);
xlim([1 xlval]);
legend('lamba3 = 1','lamba3 = 2','lamba3 = 3', 'true edges', 'BIC for lam3 = 1');
xlabel('Num. Est Edges')
ylabel('Prop Corr Est Hub Edges');
if(save_plot == 1)
    print('-dpng', '-r300', 'prop1.png') % for png
end


figure(3)
hold on
plot(cs1(:,4),cs1(:,7),'r*-');
plot(cs2(:,4),cs2(:,7),'g*-');
plot(cs3(:,4),cs3(:,7),'b*-');
h = line([tr_ed,tr_ed],ylim);
set(h,'Color','magenta');
plot(cs1(idxBIC1,4),cs1(idxBIC1,7),'k.','MarkerSize', 20);
xlim([1 xlval]);
legend('lamba3 = 1','lamba3 = 2','lamba3 = 3', 'true edges', 'BIC for lam3 = 1');
xlabel('Num. Est Edges')
ylabel('Prop Corr Est Hubs');
if(save_plot == 1)
    print('-dpng', '-r300', 'prop2.png') % for png
end


figure(4)
hold on
plot(cs1(:,4),cs1(:,8),'r*-');
plot(cs2(:,4),cs2(:,8),'g*-');
plot(cs3(:,4),cs3(:,8),'b*-');
h = line([tr_ed,tr_ed],ylim);
set(h,'Color','magenta');
plot(cs1(idxBIC1,4),cs1(idxBIC1,8),'k.','MarkerSize', 20);
xlim([1 xlval]);
legend('lamba3 = 1','lamba3 = 2','lamba3 = 3', 'true edges', 'BIC for lam3 = 1');
xlabel('Num. Est Edges')
ylabel('Sum of squared Errors');

clear cs1 cs2  cs3 h;
if(save_plot == 1)
    print('-dpng', '-r300', 'sse.png') % for png
end
