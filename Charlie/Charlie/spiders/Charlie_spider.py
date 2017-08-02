from scrapy import Spider 
from scrapy.selector import Selector
from scrapy import Request
from Charlie.items import CharlieItem

class CharlieSpider(Spider):
    name = "Charlie_spider"
    allowed_urls = ["https://www.show-score.com"]
    with open("Charlie_urls.txt", "rt") as f:
        start_urls = [url.strip() for url in f.readlines()]

    def parse(self, response):
        members = response.xpath('//div[@class="member-tile show-review-tile user_review" or @class="critic-tile critic_review show-review-tile"]')
        for i in list(range(len(members))):
            Title = members[i].xpath('.//div[@class="show-review-title"]/text()').extract()
            Score = members[i].xpath('.//span[@itemprop="ratingValue"]/text()').extract()
            Level = members[i].xpath('.//div[contains(@class, "positive") or contains(@class, "mixed") or contains(@class, "negative")]/@class').extract()
            Review_Date = members[i].xpath('.//span[@class="review-date"]/text()').extract()
            S_If =  members[i].xpath('.//p[1]/text()').extract()
            DS_If = members[i].xpath('.//p[2]/text()').extract()
            User = members[i].xpath('.//a[@class="-light-gray"]/text()').extract()
            Tastemaker = members[i].xpath('.//span[contains(@class, "tastemaker")]/@title').extract()
            Reviewer = members[i].xpath('.//span[contains(@class, "reviewer")]/@title').extract()
            Helpful = members[i].xpath('.//span[contains(@class, "helpful")]/@title').extract()
            Name_Crit = members[i].xpath('.//span[@itemprop="name"]/text()').extract() 
            Show_Name = response.xpath('//h1[@class = "h2"]/text()').extract()


            item = CharlieItem()
            item['Title'] = Title
            item['Score'] = Score 
            item['Level'] = Level
            item['Review_Date'] = Review_Date
            item['S_If'] = S_If
            item['DS_If'] = DS_If
            item["User"] = User
            item["Tastemaker"] = Tastemaker 
            item["Reviewer"] = Reviewer
            item["Helpful"] = Helpful
            item['Name_Crit'] = Name_Crit
            item["Show_Name"] = Show_Name

            yield item
        next_page = response.xpath('//li[@class="next"]/a/@href').extract()
        if next_page != []:
            next_link = "https://www.show-score.com" + next_page[0]
            yield Request(next_link, callback=self.parse)
        else: 
            pass


