clc; clear all; close all;

global n m populasyon sinir_alt sinir_ust

% x^2 + y^2 = 11'i veren x ve y değerlerini bul
% 1. Adım Başlangıç Parametrelerini Ayarlar
n = 10; % popülasyon sayısı
m = 2; % Popülasyon boyutu
sinir_alt = -5; % parametre alt değeri
sinir_ust = 5; % parametre üst değeri
delta = 0.05; % Mutasyondaki komşuluk büyüklüğü
iterasyon = 250;
rc = 0.9; % Çaprazlama oranı
rm = 0.003; % Mutasyon oranı

populasyon_olustur; % Fonksiyon çağırırken parantez kullanmadı dikkat et