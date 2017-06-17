require 'item'

class GildedRose

  attr_accessor :items

  def initialize(items)
    @items = items
  end

  def update_quality(items)
    @items.each do |item|
      if item.name == "Aged Brie"
        FoodQualityUpdater.new.update_quality(item)
      end
    end
  end
=begin
      if not_a_special_item?(item) && item.sell_in > 0
        item.quality = item.quality - 1 unless item.quality == 0
      elsif not_a_special_item?(item) && item.sell_in <= 0
        item.quality -= 2 unless item.quality == 0
      elsif aged_brie?(item) && item.quality < 50
        aged_brie_quality_check(item)
      elsif aged_brie?(item) && item.quality == 50
      elsif backstage_passes?(item)
        passes_sell_in_check(item) unless is_quality_fifty?(item)
        item.quality = 0 if item.sell_in <= 0
      elsif conjured_item?(item) && item.sell_in > 0
        item.quality -= 2 unless item.quality == 0
      elsif conjured_item?(item) && item.sell_in <= 0
        item.quality -= 4 unless item.quality == 0
      end
      item.sell_in -= 1 unless sulfuras?(item)
    end
  end
=end

  class FoodQualityUpdater

    def update_quality(item)
      quality_check(item) if item.quality < 50
      item.sell_in -= 1
    end

    private

    def quality_check(item)
      if item.sell_in > 0
        item.quality += 1
      elsif item.sell_in <= 0
        item.quality += 2
      end
    end

  end

  private

  def not_a_special_item?(item)
    item.name != "Aged Brie" && item.name != "Backstage passes to a TAFKAL80ETC concert" && item.name != "Sulfuras, Hand of Ragnaros" && item.name != "Conjured item"
  end

  def aged_brie?(item)
    item.name == "Aged Brie"
  end

  def sulfuras?(item)
    item.name == "Sulfuras, Hand of Ragnaros"
  end

  def backstage_passes?(item)
    item.name == "Backstage passes to a TAFKAL80ETC concert"
  end

  def conjured_item?(item)
    item.name == "Conjured item"
  end



  def passes_sell_in_check(item)
      if item.sell_in <= 0
      item.quality = 0
    elsif item.sell_in <= 5
      item.quality += 3
    elsif item.sell_in <= 10
      item.quality += 2
    elsif item.sell_in > 10
      item.quality += 1
    end
    item.quality = 50 if item.quality > 50
  end

  def is_quality_fifty?(item)
    item.quality == 50
  end

end
