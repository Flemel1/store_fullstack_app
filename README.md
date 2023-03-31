Untuk aplikasi mobile ada pada folder store_mobile dan API ada pada folder store-api

Framework yang digunakan
- Flutter (Mobile)
- Laravel 10 (RESTful API)

# Setup Aplikasi

## API

Ganti environment variabel SERVER_HOST pada file .env dengan IP komputer anda
Misalkan
```bash
SERVER_HOST=192.168.1.1
```
Kemudian tambahkan database mysql dengan cara
```bash
php artisan migrate
```

Kemudian jalankan server
```bash
php artisan serve
```

## Mobile
Ganti variabel konstan "baseUrl" dengan URL Laravel server yang telah dijalankan
Misalkan
```bash
const String baseUrl = 'http://192.168.1.1:8030/api/';
```

Jalankan perintah berikut pada direktori store_mobile
```bash
flutter pub run build_runner build
```