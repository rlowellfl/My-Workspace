#Import modules
import requests
import lxml
from bs4 import BeautifulSoup
import time

loops = 0

while loops <= 1000:
#define the carrierColor class
    class carrierColor:
        def __init__(self, name, url, availability, azureVariable):
            self.name = name
            self.url = url
            self.availability = availability
            self.azureVariable = azureVariable

    Umber = carrierColor("Raw Umber", "https://happybabycarriers.com/products/happy-baby-carrier/?variant=32356402397271", "Unknown", "umberAvailability")
    Cider = carrierColor("Cider", "https://happybabycarriers.com/products/happy-baby-carrier/?variant=32356401381463", "Unknown", "ciderAvailability")
    Juniper = carrierColor("Juniper", "https://happybabycarriers.com/products/happy-baby-carrier/?variant=32356401512535", "Unknown", "juniperAvailability")

    colors = Umber, Cider, Juniper

    # set the headers like we are a browser,
    headers = {'User-Agent': 'Mozilla/5.0 (Macintosh; Intel Mac OS X 10_10_1) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/39.0.2171.95 Safari/537.36'}

    for carrierColor in colors:
        # download the homepage
        response = requests.get(carrierColor.url, headers=headers)
        # parse the downloaded homepage and grab all text, then,
        soup = BeautifulSoup(response.text, "lxml")
        # if the number of times the word "Add to cart" occurs on the page is less than 1,
        if str(soup).find("ADD TO CART") > 0:
            carrierColor.availability = "In stock"
            print(carrierColor.availability + " in " + carrierColor.name)
        # but if the word "Add to cart" occurs any other number of times,
        else:
            carrierColor.availability = "Not available"
            print(carrierColor.availability + " in " + carrierColor.name)

    loops +=1
    time.sleep(5)