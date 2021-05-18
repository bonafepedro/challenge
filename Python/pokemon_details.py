import requests
import csv
import copy



def first_scrap():
    url = "https://pokeapi.co/api/v2/pokemon/"
    args = {'offset' : 0, 'limit' : 1118 }
    response = requests.get(url, params=args)
    name = []
    if response.status_code == 200:
        payload = response.json()
        results = payload.get("results", [])        
        if results:
            for pokemon in results:
                name.append(pokemon['name'])
        return name
    else:
        return 404

def scraping (name):
    args = {'offset' : 0, 'limit' : 1118 }
    response = requests.get(f"https://pokeapi.co/api/v2/pokemon/{name}/", params= args)
    if response.status_code == 200:
        response_json = response.json()
        poke_data = {
                    "ID" : "",
                    "name": "",
                    "weight": "",
                    "height": "",
                    "base_hp" : ''
                    }
        
        poke_data["ID"] = response_json["id"]
        poke_data["name"] = response_json["name"]
        poke_data["weight"] = response_json["weight"]
        poke_data["height"] = response_json["height"]
        poke_data["base_hp"] = response_json["stats"][0]["base_stat"]

        return poke_data

   
        
def execute ():
    """
    First i make a first scraping to take all the names of the pokemon from the API.
    """
    names = first_scrap()

    """
    Second i create the csv file 
    and then with the python method dictwriter i write the information.
    """

    headers = ["ID", "name", "weight", "height", "base_hp"]  
    with open('pokemon_details.csv', 'w', encoding='UTF8', newline='') as f:
        writer = csv.DictWriter(f, fieldnames=headers, extrasaction='ignore')
        writer.writeheader()

        """
        Finally i iterate the names taken in the first scraping
        and conect to the API with the specific url for each name. 
        With the scraping function i take the specific information that i need, 
        and with that i write the csv file. 
        """

        a = 1
        b = 3
        while b<=1119:
            for id in range(a,b):
                row = scraping(names[id])
                writer.writerow(row)
                print(row)
            a= copy.deepcopy(b)
            b+=3
            
    f.close()


if __name__ == "__main__":
    execute()
