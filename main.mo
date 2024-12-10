import List "mo:base/List";
import Trie "mo:base/Trie";
import Nat32 "mo:base/Nat32";
import Option "mo:base/Option";
import Array "mo:base/Array";


actor StarMap {
  public type StarId = Nat32;
  public type PlanetId = Nat32;

  public type Planet = {
    name: Text;       // Gezegenin adı
    size: Nat32;      // Gezegenin büyüklüğü (rastgele birimler)
    habitability: Bool; // Yaşam var mı?
    notes: List.List<Text>; // Keşif notları
  };

  public type Star = {
    name: Text;       // Yıldızın adı
    star_type: Text;       // Yıldızın türü (ör: "Güneş tipi", "Kırmızı cüce")
    planets: List.List<Planet>; // Yıldızın gezegenleri
  };

  private stable var nextStarId: StarId = 0;
  private stable var nextPlanetId: PlanetId = 0;

  private stable var stars: Trie.Trie<StarId, Star> = Trie.empty();
  

  // Yeni bir yıldız ekle
  public func addStar(star: Star): async StarId {
    let starId = nextStarId;
    nextStarId += 1;

    stars := Trie.replace(
      stars, 
      key(starId), 
      Nat32.equal, 
      ?star
      ).0;

    return starId;
  };

  // Yıldıza gezegen ekle
  public func addPlanetToStar(starId: StarId, planet: Planet): async Bool {
    let starOption = Trie.find(
      stars, 
      key(starId), 
      Nat32.equal
      );
      let exists = Option.isSome(starOption);
    if (exists) {
    let star = Option.unwrap(starOption);
        let updatedStar = {
        name = star.name;
        star_type = star.star_type;
        planets = List.append(star.planets, List.push(planet, List.nil()));
      };
      stars := Trie.replace(
        stars, 
        key(starId), 
        Nat32.equal, 
        ?updatedStar
        ).0;
      return true;
    };
    return false;
  };


  // Yıldızı sil
  public func deleteStar(starId: StarId): async Bool {
    let exists = Option.isSome(Trie.find(stars, key(starId), Nat32.equal));
    if (exists) {
      stars := Trie.replace(stars, key(starId), Nat32.equal, null).0;
    };
    return exists;
  };

    private func key(x: StarId): Trie.Key<StarId> {
    { hash = x; key = x };
  };

};
