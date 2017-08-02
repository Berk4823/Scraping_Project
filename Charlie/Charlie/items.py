# -*- coding: utf-8 -*-

# Define here the models for your scraped items
#
# See documentation in:
# http://doc.scrapy.org/en/latest/topics/items.html

import scrapy


class CharlieItem(scrapy.Item):
    # define the fields for your item here like:
    # name = scrapy.Field()
    Title = scrapy.Field()
    Score = scrapy.Field()
    Level = scrapy.Field()
    Review_Date = scrapy.Field()
    S_If = scrapy.Field()
    DS_If = scrapy.Field()
    Tastemaker = scrapy.Field()
    Reviewer = scrapy.Field()
    Helpful = scrapy.Field()
    User = scrapy.Field()
    Name_Crit = scrapy.Field()
    Show_Name = scrapy.Field()


    
