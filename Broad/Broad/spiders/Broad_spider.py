from scrapy import Spider 
from scrapy.selector import Selector
from scrapy import Request
from Broad.items import BroadItem
import re 

class BroadSpider(Spider):
    name = "Broad_spider"
    allowed_urls = ["https://checkout.broadway.com"]
    with open("Broad_urls.txt", "rt") as f:
        Broad_part_Urls = [url.strip() for url in f.readlines()]
        Broad_Months = ["2017/08/", "2017/09/", "2017/10/", "2017/11/", "2017/12/"]
        start_urls = sorted([i + j for j in Broad_Months for i in Broad_part_Urls])

    def broadway_id(self, x):
        y = []
        test = re.findall("\"id\": [0-9]{4,}", x)
        for i in test:
            y.append(re.findall("[0-9]{4,}", i))
        return list(map(int, [j for i in y for j in i])) 

    def parse(self, response):
        get_id = get_id = response.xpath('//script[@type="text/javascript"]/text()')
        JavaID = get_id[0].extract()
        ShowID = self.broadway_id(JavaID)


        item = BroadItem()
        item["ShowID"] = ShowID

        yield item
