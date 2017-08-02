# -*- coding: utf-8 -*-

# Define here the models for your scraped items
#
# See documentation in:
# http://doc.scrapy.org/en/latest/topics/items.html

import scrapy


class BPriceItem(scrapy.Item):
    # define the fields for your item here like:
    # name = scrapy.Field()
    Performance = scrapy.Field()
    Price = scrapy.Field()
    Ticket_Type = scrapy.Field()
    Show_Name = scrapy.Field()
    Show_Duration = scrapy.Field()
    On_Sale = scrapy.Field()
    Categories = scrapy.Field()
    Address = scrapy.Field()
    Theater = scrapy.Field()
    Capacity = scrapy.Field()

