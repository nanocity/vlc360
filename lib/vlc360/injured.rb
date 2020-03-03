module VLC360
  class Injured < Resource
    include APIResource

    attributes :name, :surname, :address, :contact_number, :contact_number2,
      :zip_code, :province, :city, :cif
  end
end
