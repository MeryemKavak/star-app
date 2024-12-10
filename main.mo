import List "mo:base/List";
import Trie "mo:base/Trie";
import Nat32 "mo:base/Nat32";

actor StarMap {
  public type StarId = Nat32;
  public type PlanetId = Nat32;

  public type Planet = {
    name: Text;        // Gezegenin adı
    size: Nat32;       // Gezegenin büyüklüğü (rastgele birimler)
    habitability: Bool; // Yaşam var mı?
    notes: List.List<Text>; // Keşif notları
  };

  public type Star = {
    name: Text;                 // Yıldızın adı
    type: Text;                 // Yıldızın türü (ör: "Güneş Tipi", "Kırmızı Cüce")
    planets: List.List<Planet>; // Yıldızın gezegenleri
  };

  private stable var nextStarId: StarId = 0;

  private stable var stars: Trie.Trie<StarId, Star> = Trie.empty();

  // Yeni bir yıldız ekle
  public func addStar(star: Star): async StarId {
    let starId = nextStarId;
    nextStarId += 1;
    stars := Trie.replace(stars, starId, Nat32.equal, star).0;
    return starId;
  };

  // Yıldıza gezegen ekle
  public func addPlanetToStar(starId: StarId, planet: Planet): async Bool {
    let starOption = Trie.find(stars, starId, Nat32.equal);
    if (Option.isSome(starOption)) {
      let star = Option.get(starOption);
      let updatedStar = {
        name = star.name;
        type = star.type;
        planets = List.append(star.planets, List.cons(planet, List.nil()));
      };
      stars := Trie.replace(stars, starId, Nat32.equal, updatedStar).0;
      return true;
    };
    return false;
  };

  // Tüm yıldızları listele
  public query func listStars(): async List.List<(StarId, Star)> {
    return Trie.entries(stars);
  };

  // Belirli bir yıldızı görüntüle
  public query func getStar(starId: StarId): async ?Star {
    return Trie.find(stars, starId, Nat32.equal);
  };

  // Yıldızı sil
  public func deleteStar(starId: StarId): async Bool {
    let exists = Option.isSome(Trie.find(stars, starId, Nat32.equal));
    if (exists) {
      stars := Trie.replace(stars, starId, Nat32.equal, null).0;
    };
    return exists;
  };

  // Keşif notu ekle
  public func addNoteToPlanet(starId: StarId, planetName: Text, note: Text): async Bool {
    let starOption = Trie.find(stars, starId, Nat32.equal);
    if (Option.isSome(starOption)) {
      let star = Option.get(starOption);
      var updatedPlanets = List.nil<Planet>();
      for (planet in star.planets.vals()) {
        if (planet.name == planetName) {
          updatedPlanets := List.append(updatedPlanets, List.cons({
            name = planet.name;
            size = planet.size;
            habitability = planet.habitability;
            notes = List.append(planet.notes, List.cons(note, List.nil()));
          }, List.nil()));
        } else {
          updatedPlanets := List.append(updatedPlanets, List.cons(planet, List.nil()));
        };
      };
      stars := Trie.replace(stars, starId, Nat32.equal, {
        name = star.name;
        type = star.type;
        planets = updatedPlanets;
      }).0;
      return true;
    };
    return false;
  };
