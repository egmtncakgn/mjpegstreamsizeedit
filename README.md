# MJPEG Stream Görüntüleyici

Bu Flutter Web uygulaması, MJPEG formatındaki video stream'lerini görüntülemek için basit ve kullanışlı bir arayüz sağlar. Uygulama, kullanıcılara stream URL'sini belirtme ve görüntü boyutlarını ayarlama imkanı sunar.

## Özellikler

- MJPEG formatında stream görüntüleme
- Stream URL'sini kolayca değiştirme
- Görüntü genişliği ve yüksekliğini ayarlama (160px-1920px genişlik, 120px-1080px yükseklik)
- En-boy oranını koruma seçeneği (4:3)
- Farklı görüntü yerleşim modları:
  - Sığdır (contain)
  - Kapla (cover)
  - Doldur (fill)
  - Orjinal (none)

## Kurulum

1. Flutter SDK'yı yükleyin (Flutter 2.0 veya üzeri gereklidir)
2. Proje dosyalarını klonlayın:
   ```
   git clone https://github.com/kullaniciadi/mjpeg-stream-viewer.git
   cd mjpeg-stream-viewer
   ```
3. Bağımlılıkları yükleyin:
   ```
   flutter pub get
   ```
4. Uygulamayı çalıştırın:
   ```
   flutter run -d chrome
   ```

## Kullanım

1. Uygulama başladığında, alt kısımdaki metin alanına MJPEG stream URL'sini girin
2. Enter tuşuna basın veya oynat simgesine tıklayın
3. Görüntünün boyutunu ayarlamak için slider'ları kullanın
4. En-boy oranını korumak için "Oranı Koru" seçeneğini işaretleyin
5. Görüntünün nasıl yerleştirileceğini belirlemek için "Görüntü Yerleşimi" açılır menüsünü kullanın

## MJPEG Stream URL Örnekleri

- IP kameralar: `http://kamera-ip-adresi:port/videostream.cgi`
- Webcam sunucuları: `http://sunucu-adresi:port/mjpeg`
- Güvenlik kameraları: `http://kullanıcı:şifre@kamera-ip-adresi/video`

## CORS Sorunları

Web tarayıcıları güvenlik nedeniyle farklı kaynaklardan içerik yüklemeyi kısıtlar (CORS). Stream URL'iniz farklı bir domainden geliyorsa aşağıdaki çözümleri deneyebilirsiniz:

1. Stream kaynağının CORS başlıklarını etkinleştirin
2. Bir proxy sunucu kullanın
3. Uygulamayı stream ile aynı domainde barındırın

## Teknik Detaylar

Bu uygulama Flutter Web platformunu kullanır ve dart:html kütüphanesi aracılığıyla HTML ImageElement'i görüntülemek için kullanır. MJPEG stream'leri, bir dizi JPEG görüntüsünün art arda gönderildiği bir formattır ve bu uygulama basit birImg elementi kullanarak bu stream'leri görüntüler.

## Lisans

MIT

## Katkıda Bulunma

1. Bu depoyu fork edin
2. Yeni bir özellik dalı oluşturun (`git checkout -b yeni-ozellik`)
3. Değişikliklerinizi commit edin (`git commit -am 'Yeni özellik: Açıklama'`)
4. Dalınıza push yapın (`git push origin yeni-ozellik`)
5. Bir Pull Request oluşturun
