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
      elsif item.name == "Sulfuras, Hand of Ragnaros"
        SulfurasQualityUpdater.new.update_quality(item)
      elsif item.name == "Backstage passes to a TAFKAL80ETC concert"
        PassesQualityUpdater.new.update_quality(item)
      elsif item.name == "Conjured item"
        ConjuredQualityUpdater.new.update_quality(item)
      else
        QualityUpdater.new.update_quality(item)
      end
      item.sell_in -= 1 unless item.name == "Sulfuras, Hand of Ragnaros"
    end
  end

  class QualityUpdater

    def update_quality(item)
      if item.sell_in > 0
        item.quality -= 1 unless item.quality == 0
      elsif item.sell_in <= 0
        item.quality -= 2 unless item.quality == 0
      end
    end
  end

  class FoodQualityUpdater

    def update_quality(item)
      quality_checker(item) if item.quality < 50
    end

    private

    def quality_checker(item)
      if item.sell_in > 0
        item.quality += 1
      elsif item.sell_in <= 0
        item.quality += 2
      end
    end
  end

  class SulfurasQualityUpdater
    def update_quality(item)
    end
  end

  class PassesQualityUpdater
    def update_quality(item)
      sell_in_checker(item) unless item.quality == 50
      item.quality = 0 if item.sell_in <= 0
    end

    private

    def sell_in_checker(item)
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
  end

  class ConjuredQualityUpdater
    def update_quality(item)
      if item.sell_in > 0
        item.quality -= 2 unless item.quality == 0
      elsif item.sell_in <= 0
        item.quality -= 4 unless item.quality == 0
      end
    end
  end
end
