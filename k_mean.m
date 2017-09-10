%Main process of k mean
clear all
close all 
% x1 to x5: 5  class sample ; x:all sample 
x1=5*[randn(500,1)+3+2*rand(1),randn(500,1)+3+2*rand(1)];
x2=5*[randn(500,1)+3+2*rand(1),randn(500,1)-3-2*rand(1)];
x3=5*[randn(500,1)-3-2*rand(1),randn(500,1)+3+2*rand(1)];
x4=5*[randn(500,1)-3-2*rand(1),randn(500,1)-3-2*rand(1)];
x5=5*[randn(500,1),randn(500,1)];
x = [x1;x2;x3;x4;x5];
figure(1);

plot(x1(:,1),x1(:,2),'k.');hold on  
plot(x2(:,1),x2(:,2),'k.'); 
plot(x3(:,1),x3(:,2),'k.'); 
plot(x4(:,1),x4(:,2),'k.'); 
plot(x5(:,1),x5(:,2),'k.'); 

k=5; % cluster number


m=size(x,1); % sample number
c_color={'r.';'g.';'m.';'c.';'b.'};  % cluster color

% c: initial centroid
for n=1:k
  c(n,:)=10*[randn(1),randn(1)];
  plot(c(n,1),c(n,2),c_color{n},'MarkerSize', 30);
  hold on;
  
end

for q=1:1000
  q % show current iterations
  % n: current sample
  % i: current centroid
  for n=1:k
    clu(n).array=[0 0];
    x_clu(n).array=0;
    y_clu(n).array=0;
  end
  deltaC=0;
  for n=1:m
    for i=1:k
      d(i)=((c(i,1)-x(n,1))^2+(c(i,2)-x(n,2))^2)^(1/2);
    end
    [M,Win_clu] = min(d);  
    clu(Win_clu).array=[clu(Win_clu).array;x(n,:)];
  end  
  for n=1:k
    clu(n).array=clu(n).array(2:end,:);
  end
  
  figure(q+1);
  for n=1:k
    
    plot(c(n,1),c(n,2),c_color{n},'MarkerSize', 30);
    hold on;
    for p=1:size(clu(n).array,1) 
      plot(clu(n).array(p,1),clu(n).array(p,2),c_color{n});
      hold on;
      x_clu(n).array=x_clu(n).array+clu(n).array(p,1);
      y_clu(n).array=y_clu(n).array+clu(n).array(p,2);
    end
    clu_size(n).array=size(clu(n).array,1);
    if (clu_size(n).array~=0) 
      Or_c=c(n,:);
      c(n,:)=[x_clu(n).array/clu_size(n).array y_clu(n).array/clu_size(n).array];
      deltaC=deltaC+(((Or_c(1,1)-c(n,1))^2)+((Or_c(1,2)-c(n,2))^2))^(1/2);
    end
  end
  
  if (deltaC==0)
    break;
  end
  pause(1);
end