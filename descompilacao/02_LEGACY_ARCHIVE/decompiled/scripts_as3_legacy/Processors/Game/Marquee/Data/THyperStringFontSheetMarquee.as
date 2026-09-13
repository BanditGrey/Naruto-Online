package Processors.Game.Marquee.Data
{
   import Foundation.Fonts.SFontCore;
   import Foundation.Fonts.TFont;
   import Foundation.Fonts.TFontEffect;
   import Logics.HyperStrings.Elements.THyperStringElement;
   import Logics.HyperStrings.Elements.THyperStringElementLinkCharacter;
   import Logics.HyperStrings.Elements.THyperStringElementLinkEvent;
   import Logics.HyperStrings.Elements.THyperStringElementLinkHero;
   import Logics.HyperStrings.Elements.THyperStringElementLinkURL;
   import Logics.HyperStrings.Elements.THyperStringElementText;
   import Rendering.HyperStrings.Data.THyperStringFontSheet;
   import Resources.Constants.CONST_CHAT;
   import Resources.Constants.CONST_EFFECT;
   
   public class THyperStringFontSheetMarquee extends THyperStringFontSheet
   {
      
      protected static const FONT_ColorURL:uint = 4286628095;
      
      protected static const FONT_DefaultName:String = CONST_CHAT.FONT_DefaultName;
      
      protected static const FONT_DefaultSize:uint = 16;
      
      protected static const FONT_DefaultColor:uint = CONST_CHAT.FONT_DefaultColor;
      
      protected var FFontSize:int = 16;
      
      protected var FFontColor:uint = 4278190080;
      
      protected var FColorText:uint;
      
      public function THyperStringFontSheetMarquee()
      {
         super();
      }
      
      override protected function ConstructFonts() : void
      {
         super.ConstructFonts();
         SFontCore.FontSelect(FFontDefault,CONST_EFFECT.TEXT_DEFAULT_FontSetName);
         FFontDefault.Size = FONT_DefaultSize;
      }
      
      override protected function ConstructFontEffects() : void
      {
         super.ConstructFontEffects();
         FFontEffectDefault.AntiAliased = true;
         FFontEffectDefault.Outlined = true;
         FFontEffectDefault.Shadowed = true;
      }
      
      override protected function FontingRegisterRoutines() : void
      {
         FontingRegisterRoutine(THyperStringElementText,this.FontingPerform_Text);
         FontingRegisterRoutine(THyperStringElementLinkURL,this.FontingPerform_LinkURL);
         FontingRegisterRoutine(THyperStringElementLinkCharacter,this.FontingPerform_LinkCharacter);
         FontingRegisterRoutine(THyperStringElementLinkHero,this.FontingPerform_LinkHero);
         FontingRegisterRoutine(THyperStringElementLinkEvent,this.FontingPerform_LinkEvent);
      }
      
      protected function FontingPerform_Text(param1:THyperStringElement, param2:TFont, param3:TFontEffect) : void
      {
         param2.Assign(FFontDefault);
         param3.Assign(FFontEffectDefault);
      }
      
      protected function FontingPerform_LinkURL(param1:THyperStringElement, param2:TFont, param3:TFontEffect) : void
      {
         param2.Assign(FFontDefault);
         param2.Bold = true;
         param2.Underline = true;
         param2.Color = FONT_ColorURL;
         param3.Assign(FFontEffectDefault);
      }
      
      protected function FontingPerform_LinkCharacter(param1:THyperStringElement, param2:TFont, param3:TFontEffect) : void
      {
         param2.Assign(FFontDefault);
         param2.Color = (param1 as THyperStringElementLinkCharacter).Color;
         param2.Underline = true;
         param3.Assign(FFontEffectDefault);
      }
      
      protected function FontingPerform_LinkHero(param1:THyperStringElement, param2:TFont, param3:TFontEffect) : void
      {
         param2.Assign(FFontDefault);
         param2.Color = (param1 as THyperStringElementLinkHero).Color;
         param2.Underline = true;
         param3.Assign(FFontEffectDefault);
      }
      
      protected function FontingPerform_LinkEvent(param1:THyperStringElement, param2:TFont, param3:TFontEffect) : void
      {
         param2.Assign(FFontDefault);
         param2.Underline = true;
         param3.Assign(FFontEffectDefault);
      }
      
      public function get ColorText() : uint
      {
         return this.FColorText;
      }
      
      public function set ColorText(param1:uint) : void
      {
         this.FColorText = param1;
      }
   }
}

