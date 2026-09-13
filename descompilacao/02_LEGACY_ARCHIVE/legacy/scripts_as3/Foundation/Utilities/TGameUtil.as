package Foundation.Utilities
{
   import Debugging.*;
   import Foundation.Common.TCoordinate;
   import Foundation.Resources.*;
   import Foundation.Resources.Repositories.*;
   import Foundation.Resources.Textures.*;
   import Foundation.Timing.STimingCore;
   import Logics.DatebaseVO.VO.Json.Post.THeroNameQualityUnderline;
   import Logics.DatebaseVO.VO.Json.Post.TItemUnderline;
   import Logics.DatebaseVO.VO.Json.Post.TPlayerCountryUnderline;
   import Logics.DatebaseVO.VO.Json.Post.TPlayerQualityUnderline;
   import Logics.DatebaseVO.VO.Json.Post.TReward;
   import Logics.DatebaseVO.VO.TSkillEffectConfig;
   import Resources.Constants.CONST_COMMON;
   import Resources.Constants.CONST_DATEBASEVO;
   import Resources.Constants.CONST_POST;
   import Resources.Strings.STRING_COMMON;
   import Resources.Strings.STRING_Mentorship;
   import flash.display.*;
   import flash.events.*;
   import flash.filters.*;
   import flash.geom.*;
   import flash.text.*;
   import flash.utils.*;
   
   public class TGameUtil
   {
      
      protected static const RENDERINGSTATE_Normal:int = 1;
      
      protected static const RENDERINGSTATE_Hovering:int = 2;
      
      protected static const RENDERINGSTATE_Pressed:int = 3;
      
      protected static const RENDERINGSTATE_Disabled:int = 4;
      
      protected static const CLASSNAMECOMBAT_VEC:Vector.<String> = CONST_POST.CLASSNAMECOMBAT_VEC;
      
      protected static const CLASSNAME_VEC:Vector.<Class> = CONST_POST.CLASSNAME_VEC;
      
      protected static const CLASSNAME_NOUNDERLINE_VEC:Vector.<Class> = CONST_POST.CLASSNAME_NOUNDERLINE_VEC;
      
      protected static const CLASSNAME_UNDERLINE_VEC:Vector.<Class> = CONST_POST.CLASSNAME_UNDERLINE_VEC;
      
      public static var Type_None:int = 0;
      
      public static var Type_HeadIcon:int = 1;
      
      public static var Type_BackgroundIcon:int = 2;
      
      public static var Type_Model:int = 3;
      
      public static var Type_LargeIcon:int = 4;
      
      public static var Type_SmallIcon:int = 5;
      
      public static var Type_Inventory:int = 6;
      
      public static var Type_Buff:int = 7;
      
      public static var Type_SkillPic:int = 8;
      
      public static var Type_DailyTask:int = 9;
      
      public static var Type_UserTitle:int = 10;
      
      public static var Type_LittlePet:int = 11;
      
      public static var Type_Pet:int = 12;
      
      public static var Type_FettersSmall:int = 13;
      
      public static var Type_FettersBig:int = 14;
      
      public static var Type_Tryout:int = 15;
      
      public static var Type_FollowBloodBound:int = 16;
      
      public static var Type_NightPower:int = 17;
      
      public static var Type_Awaken:int = 18;
      
      public static var Type_Lostsacred:int = 19;
      
      public static var Type_Wing:int = 20;
      
      public static var Type_MiddlePic:int = 21;
      
      public static var Type_Badge:int = 22;
      
      public static var Type_SpecialJade:int = 23;
      
      public static var Type_Rune:int = 24;
      
      public static var Type_Emblem:int = 25;
      
      public static var Type_Dafuben:int = 26;
      
      public static var highLightFilters:ColorMatrixFilter = new ColorMatrixFilter([1,0,0,0,80,0,1,0,0,80,0,0,1,0,80,0,0,0,1,0]);
      
      public static var darkFilters:ColorMatrixFilter = new ColorMatrixFilter([1,0,0,0,-50,0,1,0,0,-50,0,0,1,0,-50,0,0,0,1,0]);
      
      public static var ActiveDie:BlurFilter = new BlurFilter(3,15);
      
      public static var rBlackFilters:ColorMatrixFilter = new ColorMatrixFilter([1,0,0,0,0,1,0,0,0,0,1,0,0,0,0,0,0,0,1,0]);
      
      public static var gBlackFilters:ColorMatrixFilter = new ColorMatrixFilter([0,1,0,0,0,0,1,0,0,0,0,1,0,0,0,0,0,0,1,0]);
      
      public static var bBlackFilters:ColorMatrixFilter = new ColorMatrixFilter([0,0,1,0,0,0,0,1,0,0,0,0,1,0,0,0,0,0,1,0]);
      
      public static var RedFilters:ColorMatrixFilter = new ColorMatrixFilter([1,0.5,255,255,255,1,0,0,0,0,1,0,0,0,0,0,0,0,1,0]);
      
      public static var RedAntiColorFilters:ColorMatrixFilter = new ColorMatrixFilter([-0.5,0,0,0,150,0,-1,0,0,13,0,0,-1,0,0,0,0,0,1,0]);
      
      public static var AntiColorFilters:ColorMatrixFilter = new ColorMatrixFilter([-1,0,0,0,255,0,-1,0,0,255,0,0,-1,0,255,0,0,0,1,0]);
      
      public static var GaryColorFilters:ColorMatrixFilter = new ColorMatrixFilter([0.3086,0.6094,0.082,0,0,0.3086,0.6094,0.082,0,0,0.3086,0.6094,0.082,0,0,0,0,0,1,0]);
      
      public static var LeftShadowFilters:DropShadowFilter = new DropShadowFilter(10,0,0,0.3,0,0);
      
      public static var RightShadowFilters:DropShadowFilter = new DropShadowFilter(-10,0,0,0.3,0,0);
      
      public static var NameFilters:GlowFilter = new GlowFilter(404565,1,2,2,5);
      
      public static var GoldFilters:GlowFilter = new GlowFilter(16763904,1,3,3,10);
      
      public function TGameUtil()
      {
         super();
      }
      
      public static function SetBrightness(param1:DisplayObject, param2:Number) : void
      {
         var _loc3_:ColorTransform = null;
         _loc3_ = param1.transform.colorTransform;
         if(param2 >= 0)
         {
            _loc3_.redOffset = 2.55 * param2;
            _loc3_.greenOffset = 2.55 * param2;
            _loc3_.blueOffset = 2.55 * param2;
         }
         param1.transform.colorTransform = _loc3_;
      }
      
      public static function SetColorTransform(param1:DisplayObject, param2:Number) : void
      {
         var _loc3_:ColorTransform = null;
         _loc3_ = param1.transform.colorTransform;
         _loc3_.redOffset = param2;
         _loc3_.greenOffset = param2;
         _loc3_.blueOffset = param2;
         param1.transform.colorTransform = _loc3_;
      }
      
      public static function GetDistance(param1:Number, param2:Number, param3:Number, param4:Number) : Number
      {
         return Math.sqrt(Math.pow(param3 - param1,2) + Math.pow(param4 - param2,2));
      }
      
      public static function CheckInArea(param1:DisplayObject, param2:int, param3:int) : Boolean
      {
         if(param2 > -param1.width / 2 && param2 < param1.width / 2 && param3 > -param1.height && param3 < param1.y)
         {
            return true;
         }
         return false;
      }
      
      public static function CheckIsApha(param1:Bitmap, param2:int, param3:int) : Boolean
      {
         if(param1 == null)
         {
            return false;
         }
         if(param1.bitmapData == null)
         {
            return false;
         }
         if(param1.bitmapData.getPixel32(param2,param3))
         {
            return true;
         }
         return false;
      }
      
      public static function setButtonMode(param1:MovieClip, param2:Boolean) : void
      {
         if(param1 == null)
         {
            return;
         }
         if(param2)
         {
            param1.buttonMode = true;
            if(!param1.hasEventListener(MouseEvent.ROLL_OVER))
            {
               param1.addEventListener(MouseEvent.ROLL_OVER,onBtnResponse,false,0,true);
            }
            if(!param1.hasEventListener(MouseEvent.ROLL_OUT))
            {
               param1.addEventListener(MouseEvent.ROLL_OUT,onBtnResponse,false,0,true);
            }
            if(!param1.hasEventListener(MouseEvent.MOUSE_DOWN))
            {
               param1.addEventListener(MouseEvent.MOUSE_DOWN,onBtnResponse,false,0,true);
            }
            if(!param1.hasEventListener(MouseEvent.MOUSE_UP))
            {
               param1.addEventListener(MouseEvent.MOUSE_UP,onBtnResponse,false,0,true);
            }
            param1.gotoAndStop(RENDERINGSTATE_Normal);
         }
         else
         {
            param1.buttonMode = false;
            if(param1.hasEventListener(MouseEvent.ROLL_OVER))
            {
               param1.removeEventListener(MouseEvent.ROLL_OVER,onBtnResponse);
            }
            if(param1.hasEventListener(MouseEvent.ROLL_OUT))
            {
               param1.removeEventListener(MouseEvent.ROLL_OUT,onBtnResponse);
            }
            if(param1.hasEventListener(MouseEvent.MOUSE_DOWN))
            {
               param1.removeEventListener(MouseEvent.MOUSE_DOWN,onBtnResponse);
            }
            if(param1.hasEventListener(MouseEvent.MOUSE_UP))
            {
               param1.removeEventListener(MouseEvent.MOUSE_UP,onBtnResponse);
            }
            param1.gotoAndStop(RENDERINGSTATE_Disabled);
         }
         param1.mouseChildren = false;
         param1.tabEnabled = false;
      }
      
      private static function onBtnResponse(param1:MouseEvent) : void
      {
         if(!param1.currentTarget.buttonMode)
         {
            return;
         }
         if(param1.type == MouseEvent.ROLL_OVER)
         {
            param1.currentTarget.gotoAndStop(RENDERINGSTATE_Hovering);
         }
         else if(param1.type == MouseEvent.ROLL_OUT)
         {
            param1.currentTarget.gotoAndStop(RENDERINGSTATE_Normal);
         }
         else if(param1.type == MouseEvent.MOUSE_DOWN)
         {
            param1.currentTarget.gotoAndStop(RENDERINGSTATE_Pressed);
         }
         else if(param1.type == MouseEvent.MOUSE_UP)
         {
            param1.currentTarget.gotoAndStop(RENDERINGSTATE_Normal);
         }
      }
      
      public static function setMovieClipButton(param1:MovieClip, param2:Boolean, param3:Boolean = true) : void
      {
         if(param1 == null)
         {
            return;
         }
         if(param2)
         {
            param1.buttonMode = true;
            if(!param1.hasEventListener(MouseEvent.ROLL_OVER))
            {
               if(param3)
               {
                  param1.addEventListener(MouseEvent.ROLL_OVER,onMcResponse,false,10,true);
                  param1.addEventListener(MouseEvent.ROLL_OUT,onMcResponse,false,10,true);
                  param1.addEventListener(MouseEvent.MOUSE_DOWN,onMcResponse,false,10,true);
                  param1.addEventListener(MouseEvent.MOUSE_UP,onMcResponse,false,10,true);
               }
               else
               {
                  param1.addEventListener(MouseEvent.ROLL_OVER,onMcNormalResponse,false,10,true);
                  param1.addEventListener(MouseEvent.ROLL_OUT,onMcNormalResponse,false,10,true);
                  param1.addEventListener(MouseEvent.MOUSE_DOWN,onMcNormalResponse,false,10,true);
                  param1.addEventListener(MouseEvent.MOUSE_UP,onMcNormalResponse,false,10,true);
               }
            }
            param1.filters = [];
         }
         else
         {
            param1.buttonMode = false;
            if(param3)
            {
               if(param1.hasEventListener(MouseEvent.ROLL_OVER))
               {
                  param1.removeEventListener(MouseEvent.ROLL_OVER,onMcResponse);
               }
               if(param1.hasEventListener(MouseEvent.ROLL_OUT))
               {
                  param1.removeEventListener(MouseEvent.ROLL_OUT,onMcResponse);
               }
               if(param1.hasEventListener(MouseEvent.MOUSE_DOWN))
               {
                  param1.removeEventListener(MouseEvent.MOUSE_DOWN,onMcResponse);
               }
               if(param1.hasEventListener(MouseEvent.MOUSE_UP))
               {
                  param1.removeEventListener(MouseEvent.MOUSE_UP,onMcResponse);
               }
               param1.filters = [rBlackFilters];
            }
            else
            {
               if(param1.hasEventListener(MouseEvent.ROLL_OVER))
               {
                  param1.removeEventListener(MouseEvent.ROLL_OVER,onMcNormalResponse);
               }
               if(param1.hasEventListener(MouseEvent.ROLL_OUT))
               {
                  param1.removeEventListener(MouseEvent.ROLL_OUT,onMcNormalResponse);
               }
               if(param1.hasEventListener(MouseEvent.MOUSE_DOWN))
               {
                  param1.removeEventListener(MouseEvent.MOUSE_DOWN,onMcNormalResponse);
               }
               if(param1.hasEventListener(MouseEvent.MOUSE_UP))
               {
                  param1.removeEventListener(MouseEvent.MOUSE_UP,onMcNormalResponse);
               }
            }
         }
         param1.mouseChildren = false;
         param1.tabEnabled = false;
      }
      
      public static function setSpriteButton(param1:Sprite, param2:Boolean) : void
      {
         if(param1 == null)
         {
            return;
         }
         if(param2)
         {
            param1.buttonMode = true;
            if(!param1.hasEventListener(MouseEvent.ROLL_OVER))
            {
               param1.addEventListener(MouseEvent.ROLL_OVER,onMcResponse,false,0,true);
               param1.addEventListener(MouseEvent.ROLL_OUT,onMcResponse,false,0,true);
               param1.addEventListener(MouseEvent.MOUSE_DOWN,onMcResponse,false,0,true);
               param1.addEventListener(MouseEvent.MOUSE_UP,onMcResponse,false,0,true);
            }
            param1.filters = [];
         }
         else
         {
            param1.buttonMode = false;
            if(param1.hasEventListener(MouseEvent.ROLL_OVER))
            {
               param1.removeEventListener(MouseEvent.ROLL_OVER,onMcResponse);
            }
            if(param1.hasEventListener(MouseEvent.ROLL_OUT))
            {
               param1.removeEventListener(MouseEvent.ROLL_OUT,onMcResponse);
            }
            if(param1.hasEventListener(MouseEvent.MOUSE_DOWN))
            {
               param1.removeEventListener(MouseEvent.MOUSE_DOWN,onMcResponse);
            }
            if(param1.hasEventListener(MouseEvent.MOUSE_UP))
            {
               param1.removeEventListener(MouseEvent.MOUSE_UP,onMcResponse);
            }
            param1.filters = [rBlackFilters];
         }
      }
      
      private static function onMcResponse(param1:MouseEvent) : void
      {
         if(param1.type == MouseEvent.ROLL_OVER)
         {
            param1.currentTarget.filters = [highLightFilters];
         }
         else if(param1.type == MouseEvent.ROLL_OUT)
         {
            param1.currentTarget.filters = [];
         }
         else if(param1.type == MouseEvent.MOUSE_DOWN)
         {
            param1.currentTarget.filters = [darkFilters];
         }
         else if(param1.type == MouseEvent.MOUSE_UP)
         {
            param1.currentTarget.filters = [];
         }
      }
      
      private static function onMcNormalResponse(param1:MouseEvent) : void
      {
         var _loc2_:MovieClip = null;
         _loc2_ = param1.currentTarget as MovieClip;
         if(param1.type == MouseEvent.ROLL_OVER)
         {
            _loc2_.gotoAndStop(2);
         }
         else if(param1.type == MouseEvent.ROLL_OUT)
         {
            _loc2_.gotoAndStop(1);
         }
         else if(param1.type == MouseEvent.MOUSE_DOWN)
         {
            _loc2_.gotoAndStop(3);
         }
         else if(param1.type == MouseEvent.MOUSE_UP)
         {
            _loc2_.gotoAndStop(1);
         }
      }
      
      public static function fomatTime(param1:int) : String
      {
         if(param1 <= 0)
         {
            return "00:00:00";
         }
         var _loc2_:String = "";
         var _loc3_:int = param1 / 3600;
         var _loc4_:int = (param1 - _loc3_ * 3600) / 60;
         var _loc5_:int = param1 - _loc3_ * 3600 - _loc4_ * 60;
         if(_loc3_ >= 24)
         {
            return Math.floor(_loc3_ / 24) + STRING_COMMON.TYPE_TIME_Day;
         }
         if(_loc3_ >= 10)
         {
            _loc2_ += _loc3_;
         }
         else if(_loc3_ == 0)
         {
            _loc2_ += "00";
         }
         else
         {
            _loc2_ += "0" + _loc3_;
         }
         _loc2_ += ":";
         if(_loc4_ >= 10)
         {
            _loc2_ += _loc4_;
         }
         else if(_loc4_ == 0)
         {
            _loc2_ += "00";
         }
         else
         {
            _loc2_ += "0" + _loc4_;
         }
         _loc2_ += ":";
         if(_loc5_ >= 10)
         {
            _loc2_ += _loc5_;
         }
         else if(_loc5_ == 0)
         {
            _loc2_ += "00";
         }
         else
         {
            _loc2_ += "0" + _loc5_;
         }
         return _loc2_;
      }
      
      public static function fomatTime_NoDay(param1:int) : String
      {
         if(param1 <= 0)
         {
            return "00:00:00";
         }
         var _loc2_:String = "";
         var _loc3_:int = param1 / 3600;
         var _loc4_:int = (param1 - _loc3_ * 3600) / 60;
         var _loc5_:int = param1 - _loc3_ * 3600 - _loc4_ * 60;
         if(_loc3_ >= 10)
         {
            _loc2_ += _loc3_;
         }
         else if(_loc3_ == 0)
         {
            _loc2_ += "00";
         }
         else
         {
            _loc2_ += "0" + _loc3_;
         }
         _loc2_ += ":";
         if(_loc4_ >= 10)
         {
            _loc2_ += _loc4_;
         }
         else if(_loc4_ == 0)
         {
            _loc2_ += "00";
         }
         else
         {
            _loc2_ += "0" + _loc4_;
         }
         _loc2_ += ":";
         if(_loc5_ >= 10)
         {
            _loc2_ += _loc5_;
         }
         else if(_loc5_ == 0)
         {
            _loc2_ += "00";
         }
         else
         {
            _loc2_ += "0" + _loc5_;
         }
         return _loc2_;
      }
      
      public static function fomatTime_Copy(param1:int) : String
      {
         var _loc7_:int = 0;
         var _loc8_:int = 0;
         if(param1 <= 0)
         {
            return "00:00:00";
         }
         var _loc2_:String = "";
         var _loc3_:String = "";
         var _loc4_:int = param1 / 3600;
         var _loc5_:int = (param1 - _loc4_ * 3600) / 60;
         var _loc6_:int = param1 - _loc4_ * 3600 - _loc5_ * 60;
         if(_loc4_ >= 24)
         {
            _loc7_ = Math.floor(_loc4_ / 24);
            _loc8_ = param1 - _loc7_ * 24 * 3600;
            _loc3_ = _loc7_ + STRING_COMMON.TYPE_TIME_Day;
            if(_loc8_ <= 0 && _loc5_ == 0 && _loc6_ == 0)
            {
               return _loc3_;
            }
            _loc4_ = _loc8_ / 3600;
         }
         if(_loc4_ >= 10)
         {
            _loc2_ += _loc4_;
         }
         else if(_loc4_ == 0)
         {
            _loc2_ += "00";
         }
         else
         {
            _loc2_ += "0" + _loc4_;
         }
         _loc2_ += ":";
         if(_loc5_ >= 10)
         {
            _loc2_ += _loc5_;
         }
         else if(_loc5_ == 0)
         {
            _loc2_ += "00";
         }
         else
         {
            _loc2_ += "0" + _loc5_;
         }
         _loc2_ += ":";
         if(_loc6_ >= 10)
         {
            _loc2_ += _loc6_;
         }
         else if(_loc6_ == 0)
         {
            _loc2_ += "00";
         }
         else
         {
            _loc2_ += "0" + _loc6_;
         }
         return _loc3_ + _loc2_;
      }
      
      public static function FomatDayAndTime(param1:int) : String
      {
         if(param1 <= 0)
         {
            return "00:00:00";
         }
         var _loc2_:String = "";
         var _loc3_:int = param1 / (3600 * 24);
         var _loc4_:int = param1 / 3600;
         var _loc5_:int = (param1 - _loc4_ * 3600) / 60;
         var _loc6_:int = param1 - _loc4_ * 3600 - _loc5_ * 60;
         if(_loc4_ >= 24)
         {
            _loc2_ = Math.floor(_loc4_ / 24) + STRING_COMMON.TYPE_TIME_Day + " ";
            _loc4_ %= 24;
         }
         if(_loc4_ >= 10)
         {
            _loc2_ += _loc4_;
         }
         else if(_loc4_ == 0)
         {
            _loc2_ += "00";
         }
         else
         {
            _loc2_ += "0" + _loc4_;
         }
         _loc2_ += ":";
         if(_loc5_ >= 10)
         {
            _loc2_ += _loc5_;
         }
         else if(_loc5_ == 0)
         {
            _loc2_ += "00";
         }
         else
         {
            _loc2_ += "0" + _loc5_;
         }
         _loc2_ += ":";
         if(_loc6_ >= 10)
         {
            _loc2_ += _loc6_;
         }
         else if(_loc6_ == 0)
         {
            _loc2_ += "00";
         }
         else
         {
            _loc2_ += "0" + _loc6_;
         }
         return _loc2_;
      }
      
      public static function fomatSmallTime(param1:int) : String
      {
         if(param1 <= 0)
         {
            return "00:00";
         }
         var _loc2_:int = param1 / 3600;
         var _loc3_:String = "";
         var _loc4_:int = (param1 - _loc2_ * 3600) / 60;
         var _loc5_:int = param1 - _loc2_ * 3600 - _loc4_ * 60;
         if(_loc4_ >= 10)
         {
            _loc3_ += _loc4_;
         }
         else if(_loc4_ == 0)
         {
            _loc3_ += "00";
         }
         else
         {
            _loc3_ += "0" + _loc4_;
         }
         _loc3_ += ":";
         if(_loc5_ >= 10)
         {
            _loc3_ += _loc5_;
         }
         else if(_loc5_ == 0)
         {
            _loc3_ += "00";
         }
         else
         {
            _loc3_ += "0" + _loc5_;
         }
         return _loc3_;
      }
      
      public static function GetIMG(param1:int, param2:int = 0, param3:int = 0, param4:int = 0, param5:uint = 0) : TAnimationFrame
      {
         var _loc6_:TResourceRepositoryTexture = null;
         var _loc7_:TTexture = null;
         var _loc8_:TAnimationFrame = null;
         var _loc9_:TAnimationSequence = null;
         var _loc10_:BitmapData = null;
         if(param1 == Type_HeadIcon)
         {
            _loc6_ = SResourcesCore.TexturesHeadIcon;
         }
         else if(param1 == Type_BackgroundIcon)
         {
            _loc6_ = SResourcesCore.TexturesBackgroundIcon;
         }
         else if(param1 == Type_Model)
         {
            _loc6_ = SResourcesCore.TexturesModel;
         }
         else if(param1 == Type_LargeIcon)
         {
            _loc6_ = SResourcesCore.TexturesLargeIcon;
         }
         else if(param1 == Type_SmallIcon)
         {
            _loc6_ = SResourcesCore.TexturesSmallIcon;
         }
         else if(param1 == Type_Inventory)
         {
            _loc6_ = SResourcesCore.TexturesInventory;
         }
         else if(param1 == Type_Buff)
         {
            _loc6_ = SResourcesCore.TexturesBuffIcon;
         }
         else if(param1 == Type_SkillPic)
         {
            _loc6_ = SResourcesCore.TexturesSkillIcon;
         }
         else if(param1 == Type_DailyTask)
         {
            _loc6_ = SResourcesCore.TexturesDailytaskPicture;
         }
         else if(param1 == Type_Pet)
         {
            _loc6_ = SResourcesCore.TexturesPet;
         }
         else if(param1 == Type_FettersSmall)
         {
            _loc6_ = SResourcesCore.TexturesFettersSmall;
         }
         else if(param1 == Type_FettersBig)
         {
            _loc6_ = SResourcesCore.TexturesFettersBig;
         }
         else if(param1 == Type_Tryout)
         {
            _loc6_ = SResourcesCore.TexturesTryout;
         }
         else if(param1 == Type_FollowBloodBound)
         {
            _loc6_ = SResourcesCore.TexturesFollowBloodBound;
         }
         else if(param1 == Type_NightPower)
         {
            _loc6_ = SResourcesCore.TexturesNightPower;
         }
         else if(param1 == Type_Awaken)
         {
            _loc6_ = SResourcesCore.TexturesAwaken;
         }
         else if(param1 == Type_Lostsacred)
         {
            _loc6_ = SResourcesCore.TexturesLostsacred;
         }
         else if(param1 == Type_Wing)
         {
            _loc6_ = SResourcesCore.TexturesWing;
         }
         else if(param1 == Type_MiddlePic)
         {
            _loc6_ = SResourcesCore.TexturesMiddlePic;
         }
         else if(param1 == Type_Badge)
         {
            _loc6_ = SResourcesCore.TexturesBadge;
         }
         else if(param1 == Type_UserTitle)
         {
            _loc6_ = SResourcesCore.TexturesUserTitle;
         }
         else if(param1 == Type_Rune)
         {
            _loc6_ = SResourcesCore.TexturesRune;
         }
         else
         {
            if(param1 != Type_Dafuben)
            {
               return null;
            }
            _loc6_ = SResourcesCore.TexturesDafuben;
         }
         _loc7_ = _loc6_.GetTextureByIdentifier(param2);
         if(_loc7_ != null)
         {
            _loc9_ = _loc7_.GetAnimationSequenceByIndex(param3);
            if(_loc9_ != null)
            {
               _loc8_ = _loc9_.GetAnimationFrameByIndex(param4);
               if(_loc8_ != null)
               {
                  return _loc8_;
               }
            }
         }
         else
         {
            _loc6_.LoadSecondary(param2,param5);
         }
         return null;
      }
      
      public static function ShowImageByID(param1:int, param2:Bitmap, param3:uint = 0, param4:int = 0, param5:int = 0, param6:int = 0) : TCoordinate
      {
         var _loc7_:BitmapData = null;
         var _loc8_:TAnimationFrame = null;
         var _loc9_:DisplayObject = null;
         if(param4 == 0)
         {
            _loc8_ == null;
         }
         else
         {
            _loc8_ = GetIMG(param1,param4,param5,param6,param3);
         }
         if(_loc8_ == null)
         {
            _loc7_ = null;
         }
         else
         {
            _loc7_ = _loc8_.Surface;
         }
         if(param2 != null)
         {
            if(param2.bitmapData != _loc7_)
            {
               param2.bitmapData = _loc7_;
               if(_loc8_ != null)
               {
                  param2.x = -_loc8_.Pivot.X;
                  param2.y = -_loc8_.Pivot.Y;
               }
            }
         }
         if(_loc8_ != null)
         {
            return _loc8_.Pivot;
         }
         return null;
      }
      
      protected static function GetAnimationFrameByTick(param1:int, param2:TSkillEffectConfig) : uint
      {
         var _loc3_:int = 0;
         var _loc4_:uint = 0;
         var _loc5_:uint = 0;
         if(param2)
         {
            _loc5_ = 0;
            _loc4_ = param2.Frame;
            _loc3_ = 0;
            while(_loc3_ < _loc4_)
            {
               _loc5_ += param2.DurationVect[_loc3_];
               if(param1 < _loc5_)
               {
                  return _loc3_;
               }
               _loc3_++;
            }
            return 999;
         }
         return int(param1 / 70);
      }
      
      public static function ShowEffectById(param1:Bitmap, param2:int = 0) : void
      {
         var _loc3_:TSkillEffectConfig = null;
         var _loc4_:Class = null;
         var _loc5_:BitmapData = null;
         var _loc6_:uint = 0;
         _loc3_ = SResourcesCore.ResourceBin.GetDatebase(CONST_DATEBASEVO.RESOURCEID_SkillEffectConfig,param2) as TSkillEffectConfig;
         _loc6_ = GetAnimationFrameByTick(STimingCore.TickCount % _loc3_.TotleDuration,_loc3_);
         _loc4_ = TUtilityReflection.GetClass(STRING_COMMON.COMMON_ResKey + param2 + "_" + _loc6_) as Class;
         if(_loc4_ != null)
         {
            _loc5_ = new _loc4_();
            if(param1.bitmapData != _loc5_)
            {
               param1.bitmapData = _loc5_;
               param1.x = -_loc3_.PivotX;
               param1.y = -_loc3_.PivotY;
            }
         }
         if(param1.bitmapData == null)
         {
            SResourcesCore.TexturesSwfSkill.LoadSecondary(param2);
         }
      }
      
      public static function LockOrUnlockButton(param1:MovieClip, param2:Boolean) : void
      {
         if(param2)
         {
            param1.filters = [];
            param1.mouseEnabled = param2;
         }
         else
         {
            param1.filters = [gBlackFilters];
            param1.mouseEnabled = param2;
         }
      }
      
      public static function AddWindowMask(param1:Sprite, param2:Number = 0, param3:Number = 0) : void
      {
         if(param1 == null)
         {
            return;
         }
         param1.graphics.clear();
         param1.graphics.beginFill(0,0.2);
         param1.graphics.drawRect(param2,param3,CONST_COMMON.STAGE_Width,CONST_COMMON.STAGE_Height);
         param1.graphics.endFill();
      }
      
      public static function ShowAnimationByID(param1:uint, param2:Bitmap, param3:uint, param4:uint, param5:int = 0) : TCoordinate
      {
         var _loc6_:BitmapData = null;
         var _loc7_:TAnimationFrame = null;
         var _loc8_:DisplayObject = null;
         if(param4 == 0)
         {
            _loc7_ == null;
         }
         else
         {
            _loc7_ = GetAnimation(param1,param4,param5,param3);
         }
         if(_loc7_ == null)
         {
            _loc6_ = null;
         }
         else
         {
            _loc6_ = _loc7_.Surface;
         }
         if(param2 != null)
         {
            if(param2.bitmapData != _loc6_)
            {
               param2.bitmapData = _loc6_;
               if(_loc7_ != null)
               {
                  param2.x = -_loc7_.Pivot.X;
                  param2.y = -_loc7_.Pivot.Y;
               }
            }
         }
         if(_loc7_ != null)
         {
            return _loc7_.Pivot;
         }
         return null;
      }
      
      protected static function GetAnimation(param1:uint, param2:uint = 0, param3:int = 0, param4:uint = 0) : TAnimationFrame
      {
         var _loc5_:TResourceRepositoryTexture = null;
         var _loc6_:TTexture = null;
         var _loc7_:TAnimationFrame = null;
         var _loc8_:TAnimationSequence = null;
         var _loc9_:BitmapData = null;
         if(param1 == Type_UserTitle)
         {
            _loc5_ = SResourcesCore.TexturesUserTitle;
         }
         else if(param1 == Type_LittlePet)
         {
            _loc5_ = SResourcesCore.TexturesUserTitle;
         }
         else if(param1 == Type_FollowBloodBound)
         {
            _loc5_ = SResourcesCore.TexturesFollowBloodBound;
         }
         else if(param1 == Type_Wing)
         {
            _loc5_ = SResourcesCore.TexturesWing;
         }
         else if(param1 == Type_Model)
         {
            _loc5_ = SResourcesCore.TexturesModel;
         }
         else if(param1 == Type_Badge)
         {
            _loc5_ = SResourcesCore.TexturesBadge;
         }
         else if(param1 == Type_SpecialJade)
         {
            _loc5_ = SResourcesCore.TexturesSpecialJade;
         }
         else
         {
            if(param1 != Type_Emblem)
            {
               return null;
            }
            _loc5_ = SResourcesCore.TexturesEmblem;
         }
         _loc6_ = _loc5_.GetTextureByIdentifier(param2);
         if(_loc6_ != null)
         {
            _loc8_ = _loc6_.GetAnimationSequenceByIndex(param3);
            if(_loc8_ != null)
            {
               _loc7_ = _loc8_.GetAnimationFrameByTick(STimingCore.TickCount);
               if(_loc7_ != null)
               {
                  return _loc7_;
               }
            }
         }
         else
         {
            _loc5_.LoadSecondary(param2,param4);
         }
         return null;
      }
      
      public static function MakeHtmlTextStr(param1:Object, param2:uint, param3:String = "", param4:String = "") : String
      {
         var _loc5_:Array = null;
         var _loc6_:String = null;
         var _loc7_:Object = null;
         var _loc8_:String = null;
         var _loc9_:String = null;
         var _loc10_:uint = 0;
         var _loc11_:uint = 0;
         var _loc12_:String = null;
         var _loc13_:int = 0;
         var _loc14_:Class = null;
         var _loc15_:* = undefined;
         var _loc16_:* = undefined;
         _loc8_ = "";
         if(param1 == null)
         {
            return "";
         }
         if(param3 == "")
         {
            return "";
         }
         _loc7_ = param1;
         _loc5_ = param3.split("$");
         for(_loc16_ in _loc5_)
         {
            if(_loc5_[_loc16_] != "")
            {
               if(CheckHasKey(_loc5_[_loc16_],_loc7_))
               {
                  _loc6_ = _loc5_[_loc16_].split("_")[0];
                  _loc13_ = CLASSNAMECOMBAT_VEC.indexOf(_loc6_);
                  if(_loc13_ != -1)
                  {
                     _loc14_ = CLASSNAME_VEC[_loc13_];
                     _loc15_ = new _loc14_(_loc7_[_loc5_[_loc16_]] as Array);
                     if(parseInt(_loc15_["Color"]) != 0)
                     {
                        _loc9_ = parseInt(_loc15_["Color"]).toString(16);
                     }
                     _loc12_ = _loc15_["Name"];
                  }
                  _loc13_ = CLASSNAME_UNDERLINE_VEC.indexOf(_loc14_);
                  if(_loc13_ != -1)
                  {
                     switch(_loc14_)
                     {
                        case THeroNameQualityUnderline:
                        case TItemUnderline:
                           _loc10_ = parseInt(_loc15_["IDTemplate"]);
                           break;
                        case TPlayerQualityUnderline:
                        case TPlayerCountryUnderline:
                           _loc10_ = parseInt(_loc15_["Identifier0"]);
                           _loc11_ = parseInt(_loc15_["Identifier1"]);
                     }
                  }
                  else if(_loc15_ is TReward)
                  {
                     _loc12_ = _loc15_["Name"] + "*" + _loc15_["Num"];
                  }
                  _loc8_ += TUtilityString.Format(STRING_Mentorship.FORMAT_MentorshipPost,_loc9_,param4,_loc10_,_loc11_,_loc12_);
               }
               else
               {
                  _loc9_ = param2.toString(16);
                  _loc8_ += TUtilityString.Format(STRING_Mentorship.FORMAT_CommonText,_loc9_,_loc5_[_loc16_]);
               }
            }
         }
         return _loc8_;
      }
      
      protected static function CheckHasKey(param1:String, param2:Object) : Boolean
      {
         var _loc3_:* = undefined;
         for(_loc3_ in param2)
         {
            if(param1 == _loc3_)
            {
               return true;
            }
         }
         return false;
      }
      
      public static function drawCirle(param1:Shape, param2:int = 100, param3:int = 60, param4:Number = 270) : void
      {
         var _loc8_:Number = NaN;
         var _loc9_:Number = NaN;
         var _loc10_:Number = NaN;
         var _loc11_:Number = NaN;
         var _loc12_:Number = NaN;
         param1.graphics.clear();
         param1.graphics.beginFill(0,0.1);
         param1.graphics.moveTo(0,0);
         param3 = Math.abs(param3) > 360 ? 360 : param3;
         var _loc5_:Number = Math.ceil(Math.abs(param3) / 45);
         var _loc6_:Number = param3 / _loc5_;
         _loc6_ = _loc6_ * Math.PI / 180;
         param4 = param4 * Math.PI / 180;
         param1.graphics.lineTo(param2 * Math.cos(param4),param2 * Math.sin(param4));
         var _loc7_:int = 1;
         while(_loc7_ <= _loc5_)
         {
            param4 += _loc6_;
            _loc8_ = param4 - _loc6_ / 2;
            _loc9_ = param2 / Math.cos(_loc6_ / 2) * Math.cos(_loc8_);
            _loc10_ = param2 / Math.cos(_loc6_ / 2) * Math.sin(_loc8_);
            _loc11_ = param2 * Math.cos(param4);
            _loc12_ = param2 * Math.sin(param4);
            param1.graphics.curveTo(_loc9_,_loc10_,_loc11_,_loc12_);
            _loc7_++;
         }
         if(param3 != 360)
         {
            param1.graphics.lineTo(0,0);
         }
         param1.graphics.endFill();
      }
      
      public static function ChangeBtnContent(param1:DisplayObject, param2:String) : void
      {
         var _loc3_:DisplayObject = null;
         var _loc4_:int = 0;
         var _loc5_:DisplayObjectContainer = null;
         if(param1 is TextField)
         {
            TextField(param1).text = param2;
            return;
         }
         _loc5_ = param1 as DisplayObjectContainer;
         if(_loc5_)
         {
            _loc4_ = 0;
            while(_loc4_ < _loc5_.numChildren)
            {
               _loc3_ = _loc5_.getChildAt(_loc4_);
               ChangeBtnContent(_loc3_,param2);
               _loc4_++;
            }
         }
      }
   }
}

