package Foundation.Tools
{
   import flash.text.TextField;
   import ghostcat.util.easing.TweenUtil;
   
   public class DynamicWordEffect
   {
      
      protected static var tweenArray:Vector.<DynamicWordEffect> = new Vector.<DynamicWordEffect>();
      
      public var isEnd:Boolean;
      
      public var FIndex:int;
      
      protected var string:String;
      
      protected var textField:TextField;
      
      public function DynamicWordEffect()
      {
         super();
      }
      
      public static function CreateWordEffect(param1:TextField, param2:String) : DynamicWordEffect
      {
         var _loc3_:DynamicWordEffect = null;
         var _loc4_:TweenUtil = null;
         var _loc5_:int = 0;
         var _loc6_:int = 0;
         var _loc7_:int = 0;
         var _loc8_:Number = NaN;
         _loc3_ = new DynamicWordEffect();
         _loc3_.textField = param1;
         _loc3_.string = param2;
         _loc6_ = param2.length;
         _loc5_ = 0;
         _loc7_ = 15;
         _loc8_ = _loc6_ * 1000 / _loc7_;
         tweenArray.push(_loc3_);
         TweenUtil.to(_loc3_,_loc8_,{"index":_loc6_});
         return _loc3_;
      }
      
      public static function remove(param1:TextField) : void
      {
         var _loc2_:DynamicWordEffect = null;
         var _loc3_:* = 0;
         var _loc4_:int = 0;
         _loc4_ = int(tweenArray.length);
         _loc3_ = int(_loc4_ - 1);
         while(_loc3_ >= 0)
         {
            _loc2_ = tweenArray[_loc3_];
            if(_loc2_.textField == param1)
            {
               TweenUtil.removeTween(_loc2_);
               tweenArray.splice(_loc3_,1);
            }
            _loc3_--;
         }
      }
      
      public function get index() : int
      {
         return this.FIndex;
      }
      
      public function set index(param1:int) : void
      {
         this.textField.text = this.string.substr(0,param1);
         this.FIndex = param1;
      }
   }
}

