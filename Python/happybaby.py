#!/usr/bin/env python3
# Script to check the 

# while this is true (it is true by default),
# Import requests (to download the page)
import requests
import lxml
# Import BeautifulSoup (to parse what we download)
from bs4 import BeautifulSoup

# set the url to the following
url = "https://happybabycarriers.com/products/happy-baby-carrier/?variant=32356402397271"
# set the headers like we are a browser,
headers = {'User-Agent': 'Mozilla/5.0 (Macintosh; Intel Mac OS X 10_10_1) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/39.0.2171.95 Safari/537.36'}
# download the homepage
response = requests.get(url, headers=headers)
# parse the downloaded homepage and grab all text, then,
soup = BeautifulSoup(response.text, "lxml")

# if the number of times the word "Add to cart" occurs on the page is less than 1,
if str(soup).find("Add to cart") == -1:
    print('Available in Raw Umber')
# but if the word "Add to cart" occurs any other number of times,
else:
    print('Out of stock in Raw Umber')

# set the url to the following
url = "https://happybabycarriers.com/products/happy-baby-carrier/?variant=32356401512535"
# set the headers like we are a browser,
headers = {'User-Agent': 'Mozilla/5.0 (Macintosh; Intel Mac OS X 10_10_1) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/39.0.2171.95 Safari/537.36'}
# download the homepage
response = requests.get(url, headers=headers)
# parse the downloaded homepage and grab all text, then,
soup = BeautifulSoup(response.text, "lxml")

# if the number of times the word "Add to cart" occurs on the page is less than 1,
if str(soup).find("Add to cart") == -1:
    print('Available in Juniper')
# but if the word "Add to cart" occurs any other number of times,
else:
    print('Out of stock in Juniper')

# set the url to the following
url = "https://happybabycarriers.com/products/happy-baby-carrier/?variant=32356401381463"
# set the headers like we are a browser,
headers = {'User-Agent': 'Mozilla/5.0 (Macintosh; Intel Mac OS X 10_10_1) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/39.0.2171.95 Safari/537.36'}
# download the homepage
response = requests.get(url, headers=headers)
# parse the downloaded homepage and grab all text, then,
soup = BeautifulSoup(response.text, "lxml")

# if the number of times the word "Add to cart" occurs on the page is less than 1,
if str(soup).find("Add to cart") == -1:
    print('Available in Cider')
# but if the word "Add to cart" occurs any other number of times,
else:
    print('Out of stock in Cider')
#add multiple colors as objects within a JSON object and loop through each
#add results to a JSON object
#output results to the JSON object so Logic Apps can parse it