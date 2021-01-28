#Import modules
import requests
import lxml
from bs4 import BeautifulSoup
import json

#define the carrierColor class
class carrierColor:
    def __init__(self, name, url, availability):
        self.name = name
        self.url = url
        self.availability = availability

Umber = carrierColor("Raw Umber", "https://happybabycarriers.com/products/happy-baby-carrier/?variant=32356402397271", "Unknown")
Cider = carrierColor("Cider", "https://happybabycarriers.com/products/happy-baby-carrier/?variant=32356401381463", "Unknown")
Juniper = carrierColor("Juniper", "https://happybabycarriers.com/products/happy-baby-carrier/?variant=32356401512535", "Unknown")

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
        print('Available in ' + carrierColor.name)
        carrierColor.availability = "Available"
    # but if the word "Add to cart" occurs any other number of times,
    else:
        print('Out of stock in ' + carrierColor.name)
        carrierColor.availability = "Not available"

#To do:
#output results to a JSON object so Logic Apps can parse it