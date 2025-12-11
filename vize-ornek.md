# Optimizasyon Algoritmaları - Örnek Vize Soruları ve Cevapları

Bu dosya, Optimizasyon Algoritmaları dersi vize sınavı için hazırlanmış örnek soruları ve detaylı çözümlerini içermektedir.

---

## Soru 1: Optimizasyon Problemlerinin Sınıflandırılması

**Soru:** Optimizasyon problemlerini temel özelliklerine göre sınıflandırınız ve her bir sınıfı kısaca açıklayınız.

**Cevap:**
Optimizasyon problemleri, problemin yapısına ve içerdiği değişkenlerin özelliklerine göre çeşitli şekillerde sınıflandırılabilir:

1.  **Kısıtlı (Constrained) ve Kısıtsız (Unconstrained) Optimizasyon:**
    *   **Kısıtsız:** Amaç fonksiyonunu minimize/maksimize ederken değişkenler üzerinde herhangi bir sınırlama (eşitlik veya eşitsizlik) yoktur.
    *   **Kısıtlı:** Değişkenlerin sağlaması gereken belirli şartlar (örn: $x > 0$ veya $x + y = 5$) vardır.

2.  **Lineer (Linear) ve Lineer Olmayan (Nonlinear) Optimizasyon:**
    *   **Lineer Programlama (LP):** Hem amaç fonksiyonu hem de kısıtlar değişkenlerin lineer fonksiyonlarıdır.
    *   **Lineer Olmayan Programlama (NLP):** Amaç fonksiyonu veya kısıtlardan en az biri lineer değildir (örn: $x^2$, $\sin(x)$ içerir).

3.  **Sürekli (Continuous) ve Kesikli (Discrete) Optimizasyon:**
    *   **Sürekli:** Değişkenler reel sayılar kümesinden herhangi bir değer alabilir.
    *   **Kesikli (Kombinatoryal):** Değişkenler sadece tamsayılar veya belirli bir kümeden değerler alabilir (örn: Gezgin Satıcı Problemi).

4.  **Deterministik ve Stokastik Optimizasyon:**
    *   **Deterministik:** Problemdeki tüm veriler (katsayılar, kısıtlar) kesin olarak bilinir ve zamanla değişmez.
    *   **Stokastik:** Problem parametreleri rastgelelik veya belirsizlik içerir.

5.  **Tek Amaçlı ve Çok Amaçlı Optimizasyon:**
    *   **Tek Amaçlı:** Sadece bir tane amaç fonksiyonu vardır (örn: Maliyeti minimize et).
    *   **Çok Amaçlı:** Birbiriyle çelişebilen birden fazla amaç fonksiyonu aynı anda optimize edilmeye çalışılır (örn: Hem maliyeti düşür hem kaliteyi artır).

---

## Soru 2: En Dik İniş (Steepest Descent) Algoritması

**Soru:** En Dik İniş (Steepest Descent / Gradient Descent) algoritmasının çalışma mantığını açıklayınız ve algoritmanın temel adımlarını maddeler halinde yazınız.

**Cevap:**
En Dik İniş yöntemi, türevlenebilir bir fonksiyonun yerel minimumunu bulmak için kullanılan iteratif bir birinci dereceden optimizasyon algoritmasıdır. Temel mantığı, fonksiyonun o noktadaki negatif gradyanının (türevinin), fonksiyonun en hızlı azaldığı yönü göstermesidir. Bu yönde belirli bir adım atılarak minimuma yaklaşılır.

**Algoritma Adımları:**

1.  **Başlangıç:** Bir başlangıç noktası $x_0$ (tahmini çözüm), bir adım büyüklüğü (learning rate) $\alpha$ ve bir durdurma toleransı $\epsilon$ belirle. Sayaç $k=0$.
2.  **Gradyan Hesapla:** Mevcut noktadaki gradyanı hesapla: $\nabla f(x_k)$.
3.  **Yön Belirle:** İniş yönünü, gradyanın tersi olarak belirle: $d_k = -\nabla f(x_k)$.
4.  **Güncelleme:** Yeni noktayı şu formülle hesapla:
    $$x_{k+1} = x_k + \alpha \cdot d_k$$
    (veya $x_{k+1} = x_k - \alpha \cdot \nabla f(x_k)$)
5.  **Durdurma Kriteri:**
    *   Eğer gradyanın normu toleranstan küçükse ($||\nabla f(x_{k+1})|| < \epsilon$) veya maksimum iterasyon sayısına ulaşıldıysa DUR.
    *   Aksi takdirde, $k = k + 1$ yap ve 2. adıma dön.

---

## Soru 3: En Dik İniş Yöntemi Uygulaması

**Soru:** $f(x, y) = x^2 + 2y^2$ fonksiyonunu minimize etmek için En Dik İniş yöntemini kullanınız.
*   **Başlangıç Noktası:** $x^{(0)} = (2, 1)$
*   **Adım Büyüklüğü (Learning Rate):** $\alpha = 0.1$
*   **İstenen:** 2 iterasyon sonucunda elde edilen $(x, y)$ değerlerini hesaplayınız.

**Cevap:**

**Hazırlık:**
Fonksiyonun gradyan vektörü: $\nabla f(x, y) = \begin{bmatrix} \frac{\partial f}{\partial x} \\ \frac{\partial f}{\partial y} \end{bmatrix} = \begin{bmatrix} 2x \\ 4y \end{bmatrix}$

**1. İterasyon ($k=0$):**
*   Mevcut nokta: $x^{(0)} = \begin{bmatrix} 2 \\ 1 \end{bmatrix}$
*   Gradyan hesapla: $\nabla f(2, 1) = \begin{bmatrix} 2(2) \\ 4(1) \end{bmatrix} = \begin{bmatrix} 4 \\ 4 \end{bmatrix}$
*   Yeni noktayı bul:
    $$x^{(1)} = x^{(0)} - \alpha \cdot \nabla f(x^{(0)})$$
    $$x^{(1)} = \begin{bmatrix} 2 \\ 1 \end{bmatrix} - 0.1 \cdot \begin{bmatrix} 4 \\ 4 \end{bmatrix} = \begin{bmatrix} 2 - 0.4 \\ 1 - 0.4 \end{bmatrix} = \begin{bmatrix} 1.6 \\ 0.6 \end{bmatrix}$$
*   **Sonuç 1:** $x^{(1)} = (1.6, 0.6)$

**2. İterasyon ($k=1$):**
*   Mevcut nokta: $x^{(1)} = \begin{bmatrix} 1.6 \\ 0.6 \end{bmatrix}$
*   Gradyan hesapla: $\nabla f(1.6, 0.6) = \begin{bmatrix} 2(1.6) \\ 4(0.6) \end{bmatrix} = \begin{bmatrix} 3.2 \\ 2.4 \end{bmatrix}$
*   Yeni noktayı bul:
    $$x^{(2)} = x^{(1)} - \alpha \cdot \nabla f(x^{(1)})$$
    $$x^{(2)} = \begin{bmatrix} 1.6 \\ 0.6 \end{bmatrix} - 0.1 \cdot \begin{bmatrix} 3.2 \\ 2.4 \end{bmatrix} = \begin{bmatrix} 1.6 - 0.32 \\ 0.6 - 0.24 \end{bmatrix} = \begin{bmatrix} 1.28 \\ 0.36 \end{bmatrix}$$
*   **Sonuç 2:** $x^{(2)} = (1.28, 0.36)$

---

## Soru 4: Sabit Noktaların Sınıflandırılması (Hessian Matrisi)

**Soru:** $f(x, y) = x^2 - 4x + y^2 - 6y + 13$ fonksiyonunun sabit (stationary) noktasını bulunuz ve bu noktanın türünü (yerel minimum, yerel maksimum veya eyer noktası) Hessian matrisini kullanarak belirleyiniz.

**Cevap:**

**Adım 1: Sabit Noktayı Bulma (Gradyanı Sıfıra Eşitleme)**
Bir noktanın aday çözüm olabilmesi için gradyanının sıfır olması gerekir ($\nabla f = 0$).

*   $\frac{\partial f}{\partial x} = 2x - 4 = 0 \Rightarrow 2x = 4 \Rightarrow x = 2$
*   $\frac{\partial f}{\partial y} = 2y - 6 = 0 \Rightarrow 2y = 6 \Rightarrow y = 3$

**Sabit Nokta:** $(2, 3)$

**Adım 2: Hessian Matrisini Oluşturma**
İkinci dereceden kısmi türevleri hesaplayalım:
*   $f_{xx} = \frac{\partial^2 f}{\partial x^2} = 2$
*   $f_{yy} = \frac{\partial^2 f}{\partial y^2} = 2$
*   $f_{xy} = \frac{\partial^2 f}{\partial x \partial y} = 0$
*   $f_{yx} = 0$

Hessian Matrisi ($H$):
$$H = \begin{bmatrix} f_{xx} & f_{xy} \\ f_{yx} & f_{yy} \end{bmatrix} = \begin{bmatrix} 2 & 0 \\ 0 & 2 \end{bmatrix}$$

**Adım 3: Sınıflandırma**
Hessian matrisinin determinantına ve köşegen elemanlarına bakalım.
*   Determinant ($D$) = $(2 \cdot 2) - (0 \cdot 0) = 4$
*   $f_{xx} = 2$

**Kural:**
*   Eğer $D > 0$ ve $f_{xx} > 0$ ise: **Yerel Minimum**
*   Eğer $D > 0$ ve $f_{xx} < 0$ ise: **Yerel Maksimum**
*   Eğer $D < 0$ ise: **Eyer Noktası (Saddle Point)**
*   Eğer $D = 0$ ise: Belirsiz.

**Sonuç:**
Determinant pozitif ($4 > 0$) ve $f_{xx}$ pozitif ($2 > 0$) olduğu için, $(2, 3)$ noktası bir **Yerel Minimum** noktasıdır.

---

## Soru 5: Optimizasyon Algoritması Türleri

**Soru:** Optimizasyon algoritması türleri nelerdir? Bu türlerden en az birer örnek veriniz.

**Cevap:**
Optimizasyon algoritmaları genel olarak çalışma prensiplerine ve arama stratejilerine göre iki ana kategoriye ayrılabilir:

1.  **Kesin (Exact) Algoritmalar:**
    Bu algoritmalar, problemin global optimum çözümünü bulmayı garanti ederler. Genellikle küçük ve orta ölçekli problemler için uygundurlar, ancak problem boyutu büyüdükçe hesaplama maliyetleri çok artar.
    *   **Örnekler:**
        *   Simpleks Algoritması (Lineer Programlama için)
        *   Dallan ve Sınır (Branch and Bound)
        *   Dinamik Programlama

2.  **Sezgisel (Heuristic) ve Meta-Sezgisel (Meta-heuristic) Algoritmalar:**
    Bu algoritmalar, makul bir süre içinde "yeterince iyi" (optimuma yakın) çözümler bulmayı hedefler. Global optimumu bulma garantileri yoktur ancak büyük ve karmaşık problemlerde (NP-Hard gibi) etkilidirler.

    *   **Sezgisel Algoritmalar:** Genellikle belirli bir probleme özgü kurallar kullanırlar.
        *   **Örnek:** Açgözlü Yaklaşım (Greedy Approach)

    *   **Meta-Sezgisel Algoritmalar:** Problemden bağımsız genel çerçevelerdir ve genellikle doğadan esinlenirler. Kendi içlerinde de alt gruplara ayrılırlar:
        *   **Evrimsel Algoritmalar:** Genetik Algoritma (GA), Diferansiyel Gelişim (DE).
        *   **Sürü Zekası (Swarm Intelligence):** Parçacık Sürü Optimizasyonu (PSO), Karınca Kolonisi Algoritması (ACO), Yapay Arı Kolonisi (ABC).
        *   **Fizik Tabanlı:** Tavlama Benzetimi (Simulated Annealing), Yerçekimsel Arama Algoritması (GSA).
