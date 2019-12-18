# stuff the Android store needs 


From. https://play.google.com/apps/publish/?account=7105100900922845210#MarketListingPlace:p=com.winwisely.whitelabel&appid=4972552978345084231

Need to make this into a YAML and have our script reference the YAML so we can automate this
- is there a Google Play API ? YES
	- https://github.com/googleapis/google-api-go-client/blob/master/androidpublisher/v3/androidpublisher-gen.go
	- Use this !!

- All the Text needs to be in the Google sheets because it must be in every language
- Then use the googel sheet tool to download and gen the YAML
- Then use the androidpublisher-gen.go to push to the store

## Graphics

- Icon
	- NOTES:
		- 512 x 512
		- 32-bit PNG
	- FilePath: ??

- Screenshots
	- NOTES: 
		- JPEG or 24-bit PNG (no alpha). Min length for any side: 320px. Max length for any side: 3840px.
		- At least 2 screenshots are required overall. Max 8 screenshots per type. Drag to reorder or to move between types.
	- Phone
		- FilePath: ??
		- FilePath: ??
	- Tablet
		- FilePath: ??
		- FilePath: ??

- FeatureGraphic
	- NOTES:
		- 1024 w x 500 h
		- JPG or 24-bit PNG (no alpha)
	- FilePath: ??

- PromoGraphic
	- NOTES:
		- 180 w x 120 h
		- JPG or 24-bit PNG (no alpha)
	- FilePath: ??

- TVBanner
	- NOTES:
		- 1280 w x 720 h
		- JPG or 24-bit PNG (no alpha)
	- FilePath: ??

- Daydream 360 degree stereoscopic image
	- NA

- PromoVideo
	- YouTubeURL: ??
	- FilePath: ??



# Meta Data 

- ProductDetails
	- Title: ??
	- ShortDescription: ??
	- Full Description: ??

- Categorisation
	- App type: Application
	- Category: Communication
	- Tags:
		- Values: ???

- ContactDetails
	- Website: ??
	- Email: ??
	- Phone: ??

- Privacy Policy
	- WebsiteURL: ?? ( use out current one)
