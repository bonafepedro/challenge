import requests
import csv
from tenacity import retry 

"""
First i make a first scraping to take all the names of the pokemon from the API.
Second i create the csv file 
and then with the python method dictwriter i write the information.
Finally i iterate the names taken in the first scraping
and conect to the API with the specific url for each name. 
With the scraping function i take the specific information that i need, 
and with that i write the csv file. 


I installed the tenacity module to use the retry function,
to control the possible connection errors caused by the exhaustive query to the API.
"""

def first_scrap():
    """
    This function make a first scrap to take all the pokemon names in the API.
    """
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

@retry(Exception, total_tries = 10, initial_wait = 0.5)
def stop_after_10intents ():
    print ("Stopping after 10 attempts, and connection is failed")

def scraping (name):
    """
    This is the principal scrap function, heare i take the required information.
    """
    args = {'offset' : 0, 'limit' : 1118 }
    try:

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
    except requests.exceptions.ConnectionError:
        stop_after_10intents()

        
def execute ():
    """
    this function executes the two scraping functions and write the information in the csv file.
    """
    names = first_scrap()
    headers = ["ID", "name", "weight", "height", "base_hp"]  
    with open('pokemon_details.csv', 'w', encoding='UTF8', newline='') as f:
        writer = csv.DictWriter(f, fieldnames=headers, extrasaction='ignore')
        writer.writeheader()
        for id in names:
            row = scraping(id)
            writer.writerow(row)
            print(row)
        print("finish")            
    f.close()


if __name__ == "__main__":
    execute()
