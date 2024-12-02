# star-app
StarMap, Motoko dilinde yazılmış bir aktör (actor) olarak, yıldızlar ve gezegenler hakkında veri yönetimini sağlayan bir sistemdir. Bu proje, her bir yıldız için gezegenler eklemeyi, gezegenleri güncellemeyi, yıldızları silmeyi ve tüm yıldızları listelemeyi mümkün kılar.

İçerik
Yıldızlar (Stars): Her yıldızın adı, türü ve bağlı gezegenlerin listesi bulunur.
Gezegenler (Planets): Her gezegenin adı, büyüklüğü, yaşam uyumluluğu ve keşif notları tutulur.
Veri Yapısı: Yıldızlar ve gezegenler, Motoko'nun Trie veri yapısı kullanılarak saklanır.
Proje Yapısı
Bu projede aşağıdaki ana bileşenler bulunmaktadır:

StarId ve PlanetId: Her yıldız ve gezegen için benzersiz kimlikler.
Planet: Gezegenin adı, büyüklüğü, yaşam uyumluluğu ve keşif notları gibi özellikleri içerir.
Star: Yıldızın adı, türü ve gezegenlerinin listesi içerir.
Fonksiyonlar
1. addStar: Yeni bir yıldız ekler.
Parametre: star (Yıldız tipi)
Döndürür: StarId (Ekleme işlemi sonucu benzersiz yıldız kimliği)
2. addPlanetToStar: Bir yıldıza gezegen ekler.
Parametreler: starId (Yıldız kimliği), planet (Gezegen tipi)
Döndürür: Bool (Gezegen ekleme başarılı ise true, aksi takdirde false)
3. listStars: Tüm yıldızları ve gezegenlerini listeler.
Parametreler: Yok
Döndürür: List<List<(StarId, Star)>> (Tüm yıldızları ve gezegenlerini içeren liste)
4. deleteStar: Bir yıldızı siler.
Parametre: starId (Yıldız kimliği)
Döndürür: Bool (Silme başarılı ise true, aksi takdirde false)
Kurulum
Gereksinimler
Motoko SDK yüklü olmalıdır.
Adımlar
Proje Dosyasını İndirin: Bu projeyi bir klasöre indirip, içinde StarMap.mo dosyasını bulundurmalısınız.
Motoko Playground'da Çalıştırın: Motoko Playground üzerinde yeni bir aktör oluşturun ve yukarıdaki kodu kopyalayıp yapıştırın.
StarMap Aktörünü Dağıtın: Kodunuzu çalıştırmak için aktörü dağıtın ve test işlemleri yapın.
Kullanım
Yıldız Eklemek
Yeni bir yıldız eklemek için addStar fonksiyonunu kullanabilirsiniz:

let starId = await starMap.addStar({
  name = "Güneş";
  type = "Güneş tipi";
  planets = List.nil();
});
Gezegen Eklemek
Bir yıldıza gezegen eklemek için addPlanetToStar fonksiyonunu kullanabilirsiniz:

let planet = {
  name = "Dünya";
  size = 12742;  // km cinsinden
  habitability = true;
  notes = List.cons("Keşif notu: Su var", List.nil());
};
let success = await starMap.addPlanetToStar(starId, planet);
Yıldızları Listelemek
Tüm yıldızları ve gezegenleri listelemek için listStars fonksiyonunu kullanabilirsiniz:

let stars = await starMap.listStars();
Yıldız Silmek
Bir yıldızı silmek için deleteStar fonksiyonunu kullanabilirsiniz:

let deleted = await starMap.deleteStar(starId);
Katkıda Bulunma
Bu proje açık kaynaklıdır ve katkıda bulunmak isteyenler için her zaman açıktır. Katkılarınızı yaparken aşağıdaki adımları takip edebilirsiniz:

Fork edin.
Yeni bir özellik ekleyin veya bir hata düzeltmesi yapın.
Pull request gönderin.
