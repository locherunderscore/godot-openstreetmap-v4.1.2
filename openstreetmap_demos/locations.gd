extends GridContainer

var cities
var country_index

signal new_location(lat, lon)

func _ready():
	var f : FileAccess = FileAccess.open("res://openstreetmap_demos/cities.json",FileAccess.READ)
	cities = JSON.parse_string(f.get_as_text())
	f.close()
	for c in cities:
		$Country.add_item(c.country)
	select_country(0)

func select_country(i):
	country_index = i
	$City.clear()
	for c in cities[i].cities:
		$City.add_item(c.city)
	select_city(0)

func select_city(i):
	$Latitude.text = str(cities[country_index].cities[i].lat)
	$Longitude.text = str(cities[country_index].cities[i].lon)
	commit_location("")

func commit_location(_unused_param):
	emit_signal("new_location", float($Latitude.text), float($Longitude.text))
