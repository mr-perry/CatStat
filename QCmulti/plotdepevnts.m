function plotdepevnts(cat1, cat2, dep, reg)
% This function produces figures related to the events that different in 
% depth, but were similar in time and location.
% The include a map and histogram of the depth residuals.
%
% Inputs -
%   cat1 - Catalog 1 information and data
%   cat2 - Catalog 2 information and data
%   dep - Events differing in depth but similar in origin time and location
%   reg - Region of interest
%
% Output - NONE
%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%
% Formatting variables for output
%
FormatSpec1 = '%-10s %-20s %-8s %-9s %-7s %-3s %-7s \n';
FormatSpec2 = '%-10s %-20s %-8s %-9s %-7s %-3s \n';
%
% Initiate Figure
%
figure
hold on
%
% Plot world map and region
%
plotworld
%
% Plot Events on the map
%
h1 = plot(dep.cat1.Longitude,dep.cat1.Latitude,'.','Color',[1 1 1]);
h2 = plot(dep.cat1.Longitude,dep.cat1.Latitude,'r.');
h3 = plot(dep.cat2.Longitude,dep.cat2.Latitude,'b.');
%
% Restrict to Region of interest
% Get minimum and maximum values for restricted axes
%
load('regions.mat')
if strcmpi(reg,'all')
    poly(1,1) = min([cat1.data.Longitude;cat2.data.Longitude]);
    poly(2,1) = max([cat1.data.Longitude;cat2.data.Longitude]);
    poly(1,2) = min([cat1.data.Latitude;cat2.data.Latitude]);
    poly(2,2) = max([cat1.data.Latitude;cat2.data.Latitude]);
else
    ind = find(strcmp(region,reg));
    poly = coord{ind,1};
    %
    % Plot region
    %
    plot(poly(:,1),poly(:,2),'k--','LineWidth',2)
end
minlon = min(poly(:,1))-0.5;
maxlon = max(poly(:,1))+0.5;
minlat = min(poly(:,2))-0.5;
maxlat = max(poly(:,2))+1.0;
%
% Plot formatting
%
legend([h1,h2,h3],['N=',num2str(size(dep.cat1,1))],cat1.name,cat2.name)
axis([minlon maxlon minlat maxlat])
midlat = (maxlat+minlat)/2;
set(gca,'DataAspectRatio',[1,cosd(midlat),1])
xlabel('Longitude','FontSize',14)
ylabel('Latitude','FontSize',15)
set(gca,'FontSize',15)
title(['Depth residuals'],'FontSize',14)
box on
hold off
drawnow
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%
% Plot histogram of residuals
%
delDepth = dep.cat1.Depth - dep.cat2.Depth;
figure
hold on
histogram(delDepth)
%
% Figure formatting
%
xlabel(['Depth Residuals: ',cat1.name,'-',cat2.name],'FontSize',14)
ylabel('Count','FontSize',15)
set(gca,'FontSize',15)
title('Depth Residuals','FontSize',14)
axis tight
box on
hold off
drawnow
end

    