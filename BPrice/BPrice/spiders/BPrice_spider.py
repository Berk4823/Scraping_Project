from scrapy import Spider
from scrapy.selector import Selector
from scrapy import Request
from BPrice.items import BPriceItem
import re

class BPriceSpider(Spider):
    name = "BPrice_spider"
    allowed_urls = ["https://checkout.broadway.com"]
    with open("url_fixes.txt", "rt") as f:
        start_urls = [url.strip() for url in f.readlines()]

    def parse(self, response):
        get_block = response.xpath('//script[@type="text/javascript"]/text()')
        get_block2 = get_block[0].extract()
        Performance = re.findall("\"performance_time\": (\"[0-9]{4}-[0-9]+-[0-9]+T[0-9]{2}:[0-9]{2}:[0-9]{2}-[0-9]{2}:[0-9]{2}\")", get_block2)
        Price = re.findall("\"price\": (.*?),", get_block2)
        Ticket_Type = re.findall("\"name\": (\".+?\")", get_block2)
        Show_Name = re.findall("\"title\": (\".+?\")", get_block2) 
        Show_Duration = re.findall("\"duration\": (\".+?\")", get_block2) 
        On_Sale = re.findall("\"on_sale\": (.+?),", get_block2)
        Categories = re.findall("\"categories\": (\".+?\")", get_block2)
        Address = re.findall("\"venue_address_1\": (\".+?\")", get_block2)
        Theater = re.findall("\"venue_name\": (\".+?\")", get_block2)
        Capacity = re.findall("\"venue_capacity\": ([0-9]+?),", get_block2)

        item = BPriceItem()
        item["Performance"] = Performance
        item["Price"] = Price
        item["Ticket_Type"] = Ticket_Type
        item["Show_Name"] = Show_Name
        item["Show_Duration"] = Show_Duration
        item["On_Sale"] = On_Sale
        item["Categories"] = Categories
        item["Address"] = Address
        item["Theater"] = Theater
        item["Capacity"] = Capacity

        yield item
         


