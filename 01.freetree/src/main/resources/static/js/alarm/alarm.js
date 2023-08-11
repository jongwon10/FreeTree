// API 호출을 위한 URL 생성 함수
function getApiUrl(locationKey) {
    // AccuWeather API 키
    const apiKey = 'ndsi9FhhuuczEmmYaNNf24onW7JgOxRK';
    return "https://dataservice.accuweather.com/currentconditions/v1/" + locationKey + "?apikey=" + apiKey + "&language=ko-kr";
}


// 날씨 아이콘 이미지 URL 생성 함수
function getWeatherIconUrl(iconCode) {
    return "https://www.accuweather.com/images/weathericons/" + iconCode + ".svg";
}

function getWeatherData() {
    const locationKey = '226081';
    const apiUrl = getApiUrl(locationKey);

    fetch(apiUrl)
        .then(response => response.json())
        .then(data => {
            // API 응답 처리
            const weatherInfoDiv = document.getElementById('weatherInfo');
            if (data && data.length > 0) {
                const weatherData = data[0];
                const temperature = weatherData.Temperature.Metric.Value;
                const weatherText = weatherData.WeatherText;
                const weatherIcon = weatherData.WeatherIcon;

                const weatherIconUrl = getWeatherIconUrl(weatherIcon);
                const weatherIconImg = document.createElement('img');
                weatherIconImg.src = weatherIconUrl;
                weatherIconImg.alt = weatherText;

                const weatherIconDiv = document.getElementById('weatherIcon');
                weatherIconDiv.innerHTML = '';
                weatherIconDiv.appendChild(weatherIconImg);

                const weatherTextDiv = document.getElementById('weatherText');
                weatherTextDiv.textContent = weatherText;

                const temperatureDiv = document.getElementById('temperature');
                temperatureDiv.textContent = '현재 기온: ' + temperature + '°C';
            } else {
                weatherInfoDiv.textContent = '날씨 정보를 가져올 수 없습니다.';
            }
        })
        .catch(error => {
            console.error('API 호출 중 오류 발생:', error);
            const weatherInfoDiv = document.getElementById('weatherInfo');
            weatherInfoDiv.textContent = '날씨 정보를 가져오는 중 오류가 발생했습니다.';
        });
}

// 페이지가 로드될 때 한 번 호출
getWeatherData();

