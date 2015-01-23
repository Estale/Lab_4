package visual;
/* Текст количества очков игрока и соперника */
import openfl.display.*;
import openfl.text.TextFormat;
import openfl.text.TextFormatAlign;
import openfl.text.AntiAliasType;
import openfl.text.TextField;

import openfl.gl.*;
import openfl.geom.*;
import openfl.utils.*;

class ScoreText {

	/* Выравнивание текста */
	public static var ALIGN_LEFT = "left";
	public static var ALIGN_RIGHT = "right";

	/* Текстовое поле */
	var textField:TextField;
	public var width(get,null):Float;
	private var texture:GLTexture; // текстура

	public function new (aligment:String) {

		/* Шрифт */
		var format = new TextFormat();
		format.font = "Arial";
		format.size = 15;
		if(aligment == ALIGN_LEFT)
			format.align = TextFormatAlign.LEFT;
		else
			format.align = TextFormatAlign.RIGHT;

		/* Создание поля */
		textField = new TextField();
		textField.textColor = 0x00000000;
		textField.selectable = textField.border = textField.embedFonts = textField.wordWrap = false;
		textField.width = 300;
		textField.height = 25;
		textField.text = "";
		textField.defaultTextFormat = format;
	}

	/* Свойство текста только для записи */
	public var text(null, set):String;
	/* Метод, вызываемый для записи свойства */
	public function set_text (value:String):String {
		textField.text = value;

		/* (Пере)создание текстуры из текста */
		if(texture != null) GL.deleteTexture(texture);

		var bitmapData = new BitmapData(
		Math.round(textField.width),
		Math.round(textField.height),
		true, 0x00000000);
		bitmapData.draw(textField);

		var invertTransform:ColorTransform = new ColorTransform(-1,-1,-1,1,255,255,255,0);
		bitmapData.colorTransform(bitmapData.rect, invertTransform);

		#if lime
		var pixelData = @:privateAccess (bitmapData.__image).data;
		#else
		var pixelData = new UInt8Array (bitmapData.getPixels (bitmapData.rect));
		#end
		// создадим текстуру
		texture = GL.createTexture ();
		// укажем, что мы с ней работаем
		GL.bindTexture(GL.TEXTURE_2D, texture);
		// зададим параметры семплинга
		GL.texParameteri(GL.TEXTURE_2D, GL.TEXTURE_WRAP_S, GL.CLAMP_TO_EDGE);
		GL.texParameteri(GL.TEXTURE_2D, GL.TEXTURE_WRAP_T, GL.CLAMP_TO_EDGE);
		// загрузим пиксели
		GL.texImage2D(GL.TEXTURE_2D, 0, GL.RGBA,
		               bitmapData.width, bitmapData.height,
		               0, GL.RGBA, GL.UNSIGNED_BYTE, pixelData);
		// установим линейную фильтрацию (интерполяцию пикселей)
		GL.texParameteri(GL.TEXTURE_2D, GL.TEXTURE_MAG_FILTER, GL.LINEAR);
		GL.texParameteri(GL.TEXTURE_2D, GL.TEXTURE_MIN_FILTER, GL.LINEAR);
		// сделаем ее неактивной
		GL.bindTexture(GL.TEXTURE_2D, null);

		return value;
	}

	/* Свойство ширины текста */
	public function get_width ():Float {
		return textField.width;
	}

	/* Координаты */
	public var x:Float;
	public var y:Float;

	/* Отрисовка */
	public function draw () {
		if(texture == null) text = ""; // форсируем создание текстуры
		Plane.draw(65, y, x + textField.width/2, -2*textField.width/Main.SCREEN_W, 2*textField.height/Main.SCREEN_H, texture);
	}
}