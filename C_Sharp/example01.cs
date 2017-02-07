// Отправка SMS на чистом C#
using System;
using System.Net;
using System.IO;
using System.Web;

namespace smspilot
{
	class Program
	{
		public static void Main(string[] args)
		{
			string send = "Привет мир!"; // текст SMS
			string to = "79876543210"; // номер телефона в международном формате
			//  имя отправителя из списка https://smspilot.ru/my-sender.php
			string _from = "";
			// !!! Замените API-ключ на свой https://smspilot.ru/my-settings.php#api
			string apikey = "XXXXXXXXXXXXYYYYYYYYYYYYZZZZZZZZXXXXXXXXXXXXYYYYYYYYYYYYZZZZZZZZ";
			string url = "http://smspilot.ru/api.php" +
				"?send="+Uri.EscapeUriString( send ) +
				"&to=" + to +
				"&from=" + _from +
				"&apikey=" + apikey; // +
				//"&charset=windows-1251";

			HttpWebRequest myHttpWebRequest =
			  (HttpWebRequest)HttpWebRequest.Create( url );

			// выполняем запрос
			HttpWebResponse myHttpWebResponse = (HttpWebResponse)myHttpWebRequest.GetResponse();

			// выводим результат в консоль
			StreamReader myStreamReader =
			  new StreamReader(myHttpWebResponse.GetResponseStream());
			Console.WriteLine(myStreamReader.ReadToEnd());
			Console.WriteLine("Нажмите любую клавишу для завершения.");
			Console.ReadKey();

		}
	}
}