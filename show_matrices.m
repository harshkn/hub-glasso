% figure(1)
% plot(lsfnval)

figure(2)
myColorMap = jet(256);
myColorMap(1,:) = 1;
colormap(myColorMap);
colorbar


subplot(221)
imagesc(abs(true_theta))
title('True Network');

subplot(222)
imagesc(abs(theta))
title('Est Network \Theta = Z + V + V\prime');

subplot(223)
imagesc(abs(Z))
title('Z');

subplot(224)
imagesc(abs(V))
title('V');

