module ReservationsHelper

  def checkout?
    @car = Car.find(self.car_id)
    if (@car.status == "RESERVED")
        @car.status = "CHECKEDOUT"
        @car.save
        return true
    else
      return false
    end
  end
end
