import numpy as np
import matplotlib.pyplot as plt
import time

class CLONALG:
    def __init__(self, pop_size=50, n_selected=20, beta=1.0, 
                rho=2.0, d=10, max_iter=100):
        """
        Parametreler:
        pop_size: Popülasyon büyüklüğü
        n_selected: Seçilecek antikor sayısı
        beta: Klon çarpanı
        rho: Mutasyon sabiti
        d: Her iterasyonda değiştirilecek antikor sayısı
        max_iter: Maksimum iterasyon sayısı
        """
        self.pop_size = pop_size
        self.n_selected = n_selected
        self.beta = beta
        self.rho = rho
        self.d = d
        self.max_iter = max_iter
        self.memory = []  # Hafıza seti
        
    def objective_function(self, x):
        """Amaç fonksiyonu: Sphere fonksiyonu
        f(x) = ∑(xi^2)"""
        return np.sum(x**2)
    
    def affinity(self, x):
        """Afinite hesaplama: Düşük değer = Yüksek afinite 
        Affinity(x) = 1 / (1 + f(x))"""
        return 1.0 / (1.0 + self.objective_function(x))
    
    def initialize_population(self, dim, bounds):
        """Rastgele popülasyon oluştur"""
        population = []
        for _ in range(self.pop_size):
            antibody = np.random.uniform(bounds[0], bounds[1], dim)
            population.append(antibody)
        return np.array(population)
    
    def clone(self, antibodies, affinities):
        """Afiniteye göre klonlama
        n_clones = round(β x (affinity_i / ∑ affinity))"""
        clones = []
        total_affinity = np.sum(affinities)
        
        for i, antibody in enumerate(antibodies):
            # Klon sayısını hesapla
            n_clones = int(self.beta * affinities[i] / total_affinity)
            n_clones = max(1, n_clones)  # En az 1 klon
            
            # Klonları oluştur
            for _ in range(n_clones):
                clones.append(antibody.copy())
        
        return np.array(clones)
    
    def hypermutate(self, clones, affinities):
        """Afiniteye göre hipermutasyon
        mutation_rate = ρ * exp(-affinity_i)"""
        mutated = []
        
        for i, clone in enumerate(clones):
            # Mutasyon oranını hesapla (düşük afinite = yüksek mutasyon)
            mutation_rate = self.rho * np.exp(-affinities[i])
            
            # Her gene mutasyon uygula
            mutated_clone = clone.copy()
            for j in range(len(clone)):
                if np.random.random() < mutation_rate:
                    # Gaussian mutasyon
                    mutated_clone[j] += np.random.normal(0, mutation_rate)
            
            mutated.append(mutated_clone)
        
        return np.array(mutated)
    def optimize(self, dim=5, bounds=(-5, 5)):
        """Ana optimizasyon döngüsü"""
        # Popülasyonu başlat
        population = self.initialize_population(dim, bounds)
        best_scores = []
        
        for iteration in range(self.max_iter):
            # Afiniteleri hesapla
            affinities = np.array([self.affinity(ab) for ab in population])
            
            # En iyi n antikoru seç
            selected_indices = np.argsort(affinities)[-self.n_selected:]
            selected = population[selected_indices]
            selected_affinities = affinities[selected_indices]
            
            # Klonlama
            clones = self.clone(selected, selected_affinities)
            
            # Klonların afinitelerini hesapla
            clone_affinities = np.array([self.affinity(c) for c in clones])
            
            # Hipermutasyon
            mutated = self.hypermutate(clones, clone_affinities)
            
            # Mutantların afinitelerini hesapla
            mutated_affinities = np.array([self.affinity(m) for m in mutated])
            
            # Popülasyonu güncelle (en iyi olanları tut)
            combined = np.vstack([population, mutated])
            combined_affinities = np.hstack([affinities, mutated_affinities])
            best_indices = np.argsort(combined_affinities)[-self.pop_size:]
            population = combined[best_indices]
            
            # Hafızayı güncelle
            best_antibody = population[np.argmax([self.affinity(ab) 
                                                  for ab in population])]
            self.memory.append(best_antibody.copy())
            
            # Çeşitlilik koruma
            worst_indices = np.argsort([self.affinity(ab) 
                                       for ab in population])[:self.d]
            for idx in worst_indices:
                population[idx] = np.random.uniform(bounds[0], bounds[1], dim)
            
            # En iyi skoru kaydet
            best_score = min([self.objective_function(ab) for ab in population])
            best_scores.append(best_score)
            
            if iteration % 10 == 0:
                print(f"İterasyon {iteration}: En İyi Değer = {best_score:.6f}")
        
        # En iyi çözümü döndür
        best_solution = min(self.memory, key=lambda x: self.objective_function(x))
        return best_solution, best_scores

# Kullanım örneği
if __name__ == "__main__":
    ais = CLONALG(pop_size=50, n_selected=20, beta=1.0, 
                  rho=2.0, d=10, max_iter=100)
    
    # Süre ölçümü başlangıcı
    start_time = time.time()
    best_solution, history = ais.optimize(dim=5, bounds=(-5, 5))
    end_time = time.time()
    execution_time = end_time - start_time
    
    best_value = ais.objective_function(best_solution)
    
    print(f"\n--- Performans Metrikleri ---")
    print(f"Çalışma Süresi: {execution_time:.4f} saniye")
    print(f"En İyi Çözüm: {best_solution}")
    print(f"En İyi Değer: {best_value:.6f}")
    
    # Yakınsama grafiği
    plt.plot(history)
    plt.xlabel('İterasyon')
    plt.ylabel('En İyi Değer')
    plt.title(f'CLONALG Yakınsama Grafiği\nEn İyi Değer: {best_value:.6f} | Süre: {execution_time:.4f}s')
    plt.grid(True)
    plt.show()
