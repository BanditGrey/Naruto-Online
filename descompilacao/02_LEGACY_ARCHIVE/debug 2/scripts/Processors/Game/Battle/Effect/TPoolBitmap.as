package Processors.Game.Battle.Effect
{
   import flash.display.Bitmap;
   import flash.display.Sprite;
   
   public class TPoolBitmap
   {
      
      protected static var FPoolBitmap:Vector.<Bitmap> = new Vector.<Bitmap>();
      
      protected static var FPoolSprite:Vector.<Sprite> = new Vector.<Sprite>();
      
      public function TPoolBitmap()
      {
         super();
      }
      
      public static function GetBitmap() : Bitmap
      {
         var _loc1_:Bitmap = null;
         if(FPoolBitmap.length > 0)
         {
            _loc1_ = FPoolBitmap.pop();
         }
         else
         {
            _loc1_ = new Bitmap();
         }
         return _loc1_;
      }
      
      public static function SaveBitmap(param1:Bitmap) : void
      {
         if(param1 == null)
         {
            return;
         }
         if(param1.parent)
         {
            param1.parent.removeChild(param1);
         }
         if(FPoolBitmap.indexOf(param1) >= 0)
         {
            return;
         }
         param1.x = 0;
         param1.y = 0;
         param1.bitmapData = null;
         param1.scaleX = 1;
         param1.scaleY = 1;
         FPoolBitmap.push(param1);
      }
      
      public static function GetBitmapSprite() : Sprite
      {
         var _loc1_:Sprite = null;
         if(FPoolSprite.length > 0)
         {
            _loc1_ = FPoolSprite.pop();
         }
         else
         {
            _loc1_ = new Sprite();
            _loc1_.addChild(new Bitmap());
         }
         return _loc1_;
      }
      
      public static function SaveBitmapSprite(param1:Sprite) : void
      {
         var _loc2_:Bitmap = null;
         if(param1 == null)
         {
            return;
         }
         if(param1.parent)
         {
            param1.parent.removeChild(param1);
         }
         if(FPoolSprite.indexOf(param1) >= 0)
         {
            return;
         }
         _loc2_ = param1.getChildAt(0) as Bitmap;
         _loc2_.x = 0;
         _loc2_.y = 0;
         _loc2_.bitmapData = null;
         FPoolSprite.push(param1);
      }
   }
}

