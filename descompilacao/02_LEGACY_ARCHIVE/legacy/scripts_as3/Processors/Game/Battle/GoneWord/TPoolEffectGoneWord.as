package Processors.Game.Battle.GoneWord
{
   public class TPoolEffectGoneWord
   {
      
      protected static var FPoolGoneWord:Vector.<TGoneWord> = new Vector.<TGoneWord>();
      
      protected static var FPoolGoneWordWithBg:Vector.<TGoneWord> = new Vector.<TGoneWord>();
      
      public function TPoolEffectGoneWord()
      {
         super();
      }
      
      public static function GetGoneWord() : TGoneWord
      {
         var _loc1_:TGoneWord = null;
         if(FPoolGoneWord.length > 0)
         {
            _loc1_ = FPoolGoneWord.pop();
            _loc1_.ResetGoneWord();
         }
         else
         {
            _loc1_ = new TGoneWord(null);
         }
         return _loc1_;
      }
      
      public static function SaveGoneWord(param1:TGoneWord) : void
      {
         if(param1 == null)
         {
            return;
         }
         if(param1.parent)
         {
            param1.parent.removeChild(param1);
         }
         if(FPoolGoneWord.indexOf(param1) >= 0)
         {
            return;
         }
      }
      
      public static function GetGoneWordWithBg() : TGoneWord
      {
         var _loc1_:TGoneWord = null;
         if(FPoolGoneWordWithBg.length > 0)
         {
            _loc1_ = FPoolGoneWordWithBg.pop();
            _loc1_.ResetGoneWord();
         }
         else
         {
            _loc1_ = new TGoneWord(null);
         }
         return _loc1_;
      }
      
      public static function SaveGoneWordWithBg(param1:TGoneWord) : void
      {
         if(param1 == null)
         {
            return;
         }
         if(param1.parent)
         {
            param1.parent.removeChild(param1);
         }
         if(FPoolGoneWordWithBg.indexOf(param1) >= 0)
         {
            return;
         }
      }
   }
}

