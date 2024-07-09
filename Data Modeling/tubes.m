clc;
clear all;
format long;

k = 33613000.08;
data = xlsread("kab toba.xlsx");

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
populasi = data(:,2);
waktu = 0:1:10;
twaktu = waktu'; %variabel waktu yang ditranspose yang akan digunakan sebagai x pada regresi linier
Y = log(k./populasi-1);

[u, b, Sr] = regresi_fun(twaktu,Y);
a = exp(u);
r = -b;
poplog = @(t) (k./(1+a*exp(-r*t))); %model logistik 

%plot
subplot(2,2,1);
plot(waktu,poplog(waktu),"Color",'Blue'); 
hold on
scatter(twaktu,populasi);
xlabel('Tahun ke-');
ylabel('Jumlah Penduduk');
title('Kurva Model Logistik');
legend('Kurva Logistik','Data Penduduk Kota');
hold off

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

subplot(2,2,2);
time = 0:1:200;
plot(time,poplog(time));
xlabel('Tahun ke-');
ylabel('Jumlah Penduduk');
title('Proyeksi Jangka Panjang Populasi');

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

f = @(x) (k./(1+a*exp(-r*x))) - 0.8*k;

ea_fun = @(xn,xo) abs(xn-xo)/abs(xn)*100;

j = 300;
l = 450;
tol = 0.0001; %toleransi = 0.0001

fj = f(j);
fl = f(l);
ea = 1;
%pada perhitungan pertama belum ada error
%sehingga perlu dideklarasikan error
%yang lebih besar dari toleransi
i = 0;
while ea > tol
    i = i + 1;
    ea = ea_fun(j,l);
    % untuk menyimpan dalam vektor
    iter(i) = i;
    A(i) = j;
    B(i) = l;
    eas_bi(i) = ea;

    %xr atau xn atau x_i+1 metode biseksi
    c = (j+l)/2;
    C(i) = c;
    fc = f(c);

    if fj*fc < 0
        l = c;
        fl = fc;
    else
        j = c;
        fj = fc;
    end

end

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%


for i = 2:1:10
    g(i-1)=(populasi(i+1)-populasi(i-1))/2;
end
tg = 1:1:9

[u2, b2, Sr2] = regresi_fun(tg,g);
yg = @(t2) u2 + b2*t2;

subplot(2,2,3);
plot(tg,yg(tg),"Color",'Blue'); 
hold on
scatter(tg,g(tg));
xlabel('Tahun ke-');
ylabel('Perubahan Jumlah Penduduk');
title('Kurva Regeresi Linier Bagi Perubahan Penduduk Y');
legend('Garis Linier','Perubahan Penduduk Tiap Tahun');
hold off

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

Pk(1)=populasi(1);

for i = 1:1:10
    I(i) = tm(yg,u2,i);
    Pk(i+1)=Pk(1)+I(i);
end

%plot
subplot(2,2,4);
plot(waktu,poplog(waktu),"Color",'Red'); 
hold on
scatter(twaktu,populasi);
plot(waktu,Pk(waktu+1));
xlabel('Tahun ke-');
ylabel('Jumlah Penduduk');
title('Kurva Perbandingan Model Logistik dan Hasil Integrasi Numerik');
legend('Kurva Logistik','Data Penduduk Kota','Integrasi Numerik');
hold off

