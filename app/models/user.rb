class User < ApplicationRecord
    enum role: { PENGGUNA: 0, KURIR: 1 }
end
