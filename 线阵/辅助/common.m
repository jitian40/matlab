%¸¨Öúº¯Êı£¬ÓÃÓÚ»­Ô²
u=linspace(-2*pi,2*pi);
N=8;
S=0;
for k=0:N-1
    S=S+exp(1j*k.*u);
end
S=abs(S)./max(abs(S));
plot(u,S,'r');