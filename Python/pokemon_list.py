import requests

def scrap(url, args):
    """
    scraping information from the poke api
    """

    response = requests.get(url, params=args)
    if response.status_code == 200:
        payload = response.json()
        results = payload.get("results", [])
        return results
    return 404



def create_write_csv(dat, headers):
    """
    Creating csv file and load information
    """

    file = open('pokemons_list1.csv', 'w')    #creating the csv file
    file.write(headers[0] + ',' + headers[1]) #writing headers in the csv file
    file.write('\n')
    id = 1
    for poke in dat:
        name = poke['name']
        file.write(name + ',' + f'{id}\n')
        id += 1

def execute ():
    """
    This function execute all the program
    """

    api_url = "https://pokeapi.co/api/v2/pokemon/"
    arguments = {'offset' : 0, 'limit' : 1118 }
    data = scrap(api_url, arguments)
    headers = ['name', 'id']
    file = create_write_csv(data, headers)



if __name__ == "__main__":
    execute()