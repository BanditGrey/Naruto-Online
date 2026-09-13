package Processors.Game.Battle.Effect
{
   import Foundation.Resources.*;
   import Foundation.Resources.Repositories.*;
   import Foundation.Resources.Textures.*;
   import Foundation.UI.TUIComponent;
   import Foundation.Utilities.TGameUtil;
   import Foundation.Utilities.TUtilityReflection;
   import Logics.Battle.SBattleConfig;
   import Logics.Battle.model.TTargetInfo;
   import Logics.DatebaseVO.VO.TSkillEffectConfig;
   import Logics.SLogicsCore;
   import Processors.Game.Battle.Character.*;
   import Processors.Game.Battle.TBattleHandle;
   import Processors.Game.Battle.TBattleStage;
   import Resources.Constants.*;
   import Resources.Strings.STRING_COMMON;
   import flash.display.*;
   import flash.filters.GlowFilter;
   import flash.text.TextField;
   import flash.text.TextFormat;
   import flash.utils.*;
   import ghostcat.util.easing.*;
   
   public class TEffectControl
   {
      
      protected static var FTextEffect:TextField;
      
      protected static var FTextFormat:TextFormat;
      
      protected static var FBigBmp:Bitmap;
      
      protected static var FBigBlackLine:Bitmap;
      
      protected static var FlickerTimerId:uint;
      
      protected static const EFFECT_Critical:String = "EffectCritical_jsj";
      
      protected static const EFFECT_TARGET:int = 0;
      
      protected static const EFFECT_RESOURCE_ID:int = 1;
      
      protected static const EFFECT_CURINDEX:int = 2;
      
      protected static const EFFECT_LOGIC:int = 3;
      
      protected static const EFFECT_SOURCE:int = 4;
      
      protected static const EFFECT_INITIATOR:int = 5;
      
      protected static const EFFECT_TARGETS:int = 6;
      
      protected static const EFFECT_RESULTS:int = 7;
      
      protected static const EFFECT_RESETPOSINT_X:int = 8;
      
      protected static const EFFECT_RESETPOSINT_Y:int = 9;
      
      protected static const EFFECT_POINT_X:int = 10;
      
      protected static const EFFECT_POINT_Y:int = 11;
      
      protected static const EFFECT_BMP:int = 12;
      
      protected static const EFFECT_TICK:int = 13;
      
      protected static const EFFECT_TEXTFUNCTION:int = 14;
      
      protected static const EFFECT_SPEED_X:int = 15;
      
      protected static const EFFECT_SPEED_Y:int = 16;
      
      protected static const EFFECT_MOVE_TICK:int = 17;
      
      protected static const EFFECT_MOVE_X:int = 18;
      
      protected static const EFFECT_MOVE_Y:int = 19;
      
      protected static const EFFECT_CONFIGINFO:int = 20;
      
      protected static const EFFECT_PUBLIC_TARGET:int = 0;
      
      protected static const EFFECT_PUBLIC_RESOURCE_ID:int = 1;
      
      protected static const EFFECT_PUBLIC_BMP:int = 2;
      
      protected static const EFFECT_PUBLIC_CURINDEX:int = 3;
      
      protected static const EFFECT_PUBLIC_POINT_X:int = 4;
      
      protected static const EFFECT_PUBLIC_POINT_Y:int = 5;
      
      protected static const EFFECT_PUBLIC_TICK:int = 6;
      
      protected static const EFFECT_PUBLIC_CALLBACK:int = 7;
      
      protected static const EFFECT_PUBLIC_CONFIGINFO:int = 8;
      
      protected static const EFFECT_SPECIALCHAIN_SPRITELIST:int = 0;
      
      protected static const EFFECT_SPECIALCHAIN_RESOURCE_ID:int = 1;
      
      protected static const EFFECT_SPECIALCHAIN_SOUND_ID:int = 2;
      
      protected static const EFFECT_SPECIALCHAIN_ATTACKEFFECT:int = 3;
      
      protected static const EFFECT_SPECIALCHAIN_TARGETS:int = 4;
      
      protected static const EFFECT_SPECIALCHAIN_RESULTS:int = 5;
      
      protected static const EFFECT_SPECIALCHAIN_SHOWINDEX:int = 6;
      
      protected static const EFFECT_SPECIALCHAIN_INDEXTICK:int = 7;
      
      protected static const EFFECT_SPECIALCHAIN_TICK:int = 8;
      
      protected static const EFFECT_SPECIALCHAIN_TEXTFUNCTION:int = 9;
      
      protected static const EFFECT_SPECIALCHAIN_CONFIGINFO:int = 10;
      
      protected static var FSharkDict:Dictionary = new Dictionary(true);
      
      protected static var FRoleVect:Vector.<Vector.<Object>> = new Vector.<Vector.<Object>>();
      
      protected static var FRoleSpecialChainVect:Vector.<Vector.<Object>> = new Vector.<Vector.<Object>>();
      
      protected static var FPublicEffectVect:Vector.<Vector.<Object>> = new Vector.<Vector.<Object>>();
      
      public function TEffectControl()
      {
         super();
      }
      
      public static function get EffectCount() : int
      {
         return FRoleVect.length + FRoleSpecialChainVect.length;
      }
      
      private static function IsHave(param1:DisplayObjectContainer, param2:uint) : Boolean
      {
         var _loc3_:uint = 0;
         var _loc4_:DisplayObjectContainer = null;
         var _loc5_:uint = 0;
         var _loc6_:uint = 0;
         _loc3_ = 0;
         while(_loc3_ < FRoleVect.length)
         {
            _loc4_ = FRoleVect[_loc3_][EFFECT_TARGET] as DisplayObjectContainer;
            _loc5_ = FRoleVect[_loc3_][EFFECT_RESOURCE_ID] as uint;
            _loc6_ = FRoleVect[_loc3_][EFFECT_CURINDEX] as uint;
            if(param1 == _loc4_ && param2 == _loc5_ && _loc6_ == 0)
            {
               return true;
            }
            _loc3_++;
         }
         return false;
      }
      
      public static function ShowEffect(param1:DisplayObjectContainer, param2:uint, param3:Object = null, param4:TRole = null, param5:TRole = null, param6:Vector.<TRole> = null, param7:Vector.<TTargetInfo> = null, param8:Number = 0, param9:Number = 0, param10:Number = 0, param11:Number = 0, param12:Function = null, param13:int = 0, param14:int = 0, param15:int = 0, param16:int = 1, param17:int = -1, param18:Boolean = true) : void
      {
         var _loc19_:Bitmap = null;
         var _loc20_:TSkillEffectConfig = null;
         if(param18 && IsHave(param1,param2))
         {
            return;
         }
         _loc20_ = SResourcesCore.ResourceBin.GetDatebase(CONST_DATEBASEVO.RESOURCEID_SkillEffectConfig,param2) as TSkillEffectConfig;
         _loc19_ = TPoolBitmap.GetBitmap();
         _loc19_.scaleX = param16;
         if(param1 is TRole)
         {
            (param1 as TRole).EffectSprite.addChild(_loc19_);
         }
         else if(param1 is TBattleStage)
         {
            (param1 as TBattleStage).EffectSprite.addChild(_loc19_);
         }
         else
         {
            if(!(param1 is TUIComponent))
            {
               return;
            }
            if(param17 < 0)
            {
               (param1 as TUIComponent).addChild(_loc19_);
            }
            else
            {
               (param1 as TUIComponent).addChildAt(_loc19_,param17);
            }
         }
         FRoleVect.push(Vector.<Object>([param1,param2,-1,param3,param4,param5,param6,param7,param8,param9,param10,param11,_loc19_,0,param12,param13,param14,param15,0,0,_loc20_]));
      }
      
      public static function ShowSpecialChainEffect(param1:TBattleStage, param2:uint, param3:Object, param4:Vector.<TRole>, param5:Vector.<TTargetInfo>, param6:Function = null) : void
      {
         var _loc7_:uint = 0;
         var _loc8_:uint = 0;
         var _loc9_:uint = 0;
         var _loc10_:Vector.<Sprite> = null;
         var _loc11_:Vector.<uint> = null;
         var _loc12_:Bitmap = null;
         var _loc13_:Number = NaN;
         var _loc14_:Number = NaN;
         var _loc15_:Number = NaN;
         var _loc16_:Number = NaN;
         var _loc17_:Sprite = null;
         var _loc18_:TSkillEffectConfig = null;
         _loc18_ = SResourcesCore.ResourceBin.GetDatebase(CONST_DATEBASEVO.RESOURCEID_SkillEffectConfig,param2) as TSkillEffectConfig;
         _loc8_ = param4.length;
         _loc10_ = new Vector.<Sprite>();
         _loc11_ = new Vector.<uint>();
         _loc7_ = 0;
         while(_loc7_ < _loc8_ - 1)
         {
            _loc12_ = TPoolBitmap.GetBitmap();
            _loc17_ = new Sprite();
            _loc10_.push(_loc17_);
            _loc11_.push(0);
            _loc13_ = param4[_loc7_].x;
            _loc14_ = param4[_loc7_].y;
            _loc15_ = param4[_loc7_ + 1].x;
            _loc16_ = param4[_loc7_ + 1].y;
            _loc17_.x = (_loc13_ + _loc15_) / 2;
            _loc17_.y = (_loc14_ + _loc16_) / 2;
            _loc17_.visible = false;
            _loc17_.scaleX = Math.sqrt(Math.pow(_loc15_ - _loc13_,2) + Math.pow(_loc16_ - _loc14_,2)) / 270;
            _loc17_.rotation = Math.atan((_loc16_ - _loc14_) / (_loc15_ - _loc13_)) / Math.PI * 180;
            _loc17_.y -= 60;
            _loc17_.addChild(_loc12_);
            param1.EffectSprite.addChild(_loc17_);
            _loc7_++;
         }
         FRoleSpecialChainVect.push(Vector.<Object>([_loc10_,param2,param3.voice,param3.AttackedEffectId,param4,param5,-1,350,_loc11_,param6,_loc18_]));
      }
      
      public static function ShowPublicEffect(param1:DisplayObjectContainer, param2:uint, param3:Number = 0, param4:Number = 0, param5:Function = null) : void
      {
         var _loc6_:Bitmap = null;
         var _loc7_:TSkillEffectConfig = null;
         _loc7_ = SResourcesCore.ResourceBin.GetDatebase(CONST_DATEBASEVO.RESOURCEID_SkillEffectConfig,param2) as TSkillEffectConfig;
         _loc6_ = TPoolBitmap.GetBitmap();
         param1.addChild(_loc6_);
         FPublicEffectVect.push(Vector.<Object>([param1,param2,_loc6_,-1,param3,param4,0,param5,_loc7_]));
      }
      
      public static function ShowMoveEffect(param1:DisplayObject, param2:Number, param3:Number, param4:uint, param5:Function = null) : void
      {
         var EndMove:Function = null;
         var Container:DisplayObject = param1;
         var EndPosX:Number = param2;
         var EndPosY:Number = param3;
         var CostTime:uint = param4;
         var Callback:Function = param5;
         EndMove = function():void
         {
            if(Callback != null)
            {
               Callback(Container);
            }
         };
         TweenUtil.to(Container,CostTime,{
            "x":EndPosX,
            "y":EndPosY,
            "onComplete":EndMove
         });
      }
      
      public static function ShowUIEffect(param1:TBattleStage, param2:uint, param3:int, param4:String, param5:Function = null) : void
      {
         var Textures:TResourceRepositoryTexture = null;
         var Texture:TTexture = null;
         var Sequence:TAnimationSequence = null;
         var Frame:TAnimationFrame = null;
         var BmpData:BitmapData = null;
         var bmdClass:Class = null;
         var OnMoveEnd:Function = null;
         var scene:MovieClip = null;
         var BattleStage:TBattleStage = param1;
         var Id:uint = param2;
         var Direction:int = param3;
         var NameTxt:String = param4;
         var CallBack:Function = param5;
         OnMoveEnd = function():void
         {
            FBigBmp.visible = false;
            FTextEffect.visible = false;
            FBigBlackLine.visible = false;
            if(CallBack != null)
            {
               setTimeout(CallBack,400);
            }
         };
         if(FBigBlackLine == null)
         {
            bmdClass = TUtilityReflection.GetClass(STRING_COMMON.COMMON_ResKey + CONST_BATTLE.EFFECT_BIGBLACK_ID + "_0") as Class;
            FBigBlackLine = TPoolBitmap.GetBitmap();
            if(bmdClass != null)
            {
               BmpData = new bmdClass();
               if(FBigBlackLine.bitmapData != BmpData)
               {
                  FBigBlackLine.bitmapData = BmpData;
               }
            }
            FBigBlackLine.y = 186 + 170;
         }
         BattleStage.addChild(FBigBlackLine);
         if(FBigBmp == null)
         {
            FBigBmp = TPoolBitmap.GetBitmap();
         }
         BattleStage.addChild(FBigBmp);
         Textures = SResourcesCore.TexturesLargeIcon;
         Texture = Textures.GetTextureByIdentifier(Id);
         if(Texture == null)
         {
            FBigBmp.visible = false;
            if(FTextEffect != null)
            {
               FTextEffect.visible = false;
            }
            FBigBlackLine.visible = false;
            if(CallBack != null)
            {
               CallBack();
            }
            return;
         }
         Sequence = Texture.GetAnimationSequenceByIndex(0);
         if(Sequence != null)
         {
            Frame = Sequence.GetAnimationFrameByIndex(0);
            if(Frame != null)
            {
               BmpData = Frame.Surface;
               if(FBigBmp.bitmapData != BmpData)
               {
                  FBigBmp.bitmapData = BmpData;
               }
            }
         }
         if(FTextEffect == null)
         {
            scene = TUtilityReflection.CreateDisplayObjectInstance(CONST_BATTLE.RESOURCE_ClassName_Text) as MovieClip;
            FTextEffect = scene.tf_text;
            FTextFormat = FTextEffect.getTextFormat();
            FTextFormat.size = 60;
            FTextFormat.color = 16777215;
            FTextEffect.filters = [new GlowFilter(4281475875,1,6,6,5)];
         }
         BattleStage.addChild(FTextEffect);
         FBigBlackLine.visible = true;
         FBigBmp.visible = true;
         FTextEffect.visible = true;
         FTextEffect.text = NameTxt;
         FTextEffect.setTextFormat(FTextFormat);
         FTextEffect.x = 450;
         FTextEffect.y = 223 + 160;
         if(Direction == 0)
         {
            FBigBmp.filters = [TGameUtil.LeftShadowFilters];
            FBigBmp.x = 228;
            FBigBmp.y = 140;
            FTextEffect.x = 620;
            TweenUtil.to(FBigBmp,1000,{
               "x":FBigBmp.x - 20,
               "onComplete":OnMoveEnd
            });
            TweenUtil.to(FTextEffect,1000,{"x":FTextEffect.x + 20});
         }
         else
         {
            FBigBmp.filters = [TGameUtil.RightShadowFilters];
            FBigBmp.x = 699;
            FBigBmp.y = 140;
            FTextEffect.x = 600 - FTextEffect.textWidth;
            TweenUtil.to(FBigBmp,1000,{
               "x":FBigBmp.x + 20,
               "onComplete":OnMoveEnd
            });
            TweenUtil.to(FTextEffect,1000,{"x":FTextEffect.x - 20});
         }
      }
      
      public static function MakeCritical(param1:TBattleHandle) : void
      {
         var BmpData:BitmapData = null;
         var Bmp:Bitmap = null;
         var Critical:DisplayObjectContainer = null;
         var bmdClass:Class = null;
         var SkillEffectConfig:TSkillEffectConfig = null;
         var ClearCritical:Function = null;
         var Container:TBattleHandle = param1;
         ClearCritical = function():void
         {
            Critical.visible = false;
            clearInterval(FlickerTimerId);
         };
         Critical = Container.getChildByName(EFFECT_Critical) as DisplayObjectContainer;
         if(Critical == null)
         {
            Critical = new Sprite();
            Critical.name = EFFECT_Critical;
            Container.addChild(Critical);
            SkillEffectConfig = SResourcesCore.ResourceBin.GetDatebase(CONST_DATEBASEVO.RESOURCEID_SkillEffectConfig,CONST_BATTLE.Public_Effect_Crit) as TSkillEffectConfig;
            bmdClass = TUtilityReflection.GetClass(STRING_COMMON.COMMON_ResKey + CONST_BATTLE.Public_Effect_Crit + "_0") as Class;
            if(bmdClass != null)
            {
               BmpData = new bmdClass();
               Bmp = TPoolBitmap.GetBitmap();
               Bmp.bitmapData = BmpData;
               Bmp.x = -SkillEffectConfig.PivotX;
               Bmp.y = -SkillEffectConfig.PivotY;
               Bmp.x += Container.width > CONST_COMMON.STAGE_Width ? CONST_COMMON.STAGE_Width : Container.width;
               Critical.addChild(Bmp);
               Bmp = TPoolBitmap.GetBitmap();
               Bmp.bitmapData = BmpData;
               Bmp.x = SkillEffectConfig.PivotX;
               Bmp.y = -SkillEffectConfig.PivotY;
               Bmp.scaleX = -1;
               Critical.addChild(Bmp);
               Bmp = TPoolBitmap.GetBitmap();
               Bmp.bitmapData = BmpData;
               Bmp.x = SkillEffectConfig.PivotX;
               Bmp.y = SkillEffectConfig.PivotY;
               Bmp.scaleX = -1;
               Bmp.scaleY = -1;
               Bmp.y += Container.height > CONST_COMMON.STAGE_Height ? CONST_COMMON.STAGE_Height : Container.height;
               Critical.addChild(Bmp);
               Bmp = TPoolBitmap.GetBitmap();
               Bmp.bitmapData = BmpData;
               Bmp.x = -SkillEffectConfig.PivotX;
               Bmp.y = SkillEffectConfig.PivotY;
               Bmp.scaleY = -1;
               Bmp.x += Container.width > CONST_COMMON.STAGE_Width ? CONST_COMMON.STAGE_Width : Container.width;
               Bmp.y += Container.height > CONST_COMMON.STAGE_Height ? CONST_COMMON.STAGE_Height : Container.height;
               Critical.addChild(Bmp);
            }
         }
         clearInterval(FlickerTimerId);
         FlickerTimerId = PlayFlicker(Critical,50);
         PlayShake(Container,10,ClearCritical);
      }
      
      public static function RemoveEffect(param1:DisplayObjectContainer, param2:uint = 0) : void
      {
         var _loc3_:int = 0;
         var _loc4_:uint = 0;
         var _loc5_:Vector.<Object> = null;
         var _loc6_:DisplayObjectContainer = null;
         var _loc7_:Bitmap = null;
         _loc3_ = 0;
         while(_loc3_ < FRoleVect.length)
         {
            _loc5_ = FRoleVect[_loc3_];
            if(_loc5_ != null)
            {
               _loc6_ = _loc5_[EFFECT_TARGET] as DisplayObjectContainer;
               _loc4_ = _loc5_[EFFECT_RESOURCE_ID] as uint;
               _loc7_ = _loc5_[EFFECT_BMP] as Bitmap;
               if(_loc6_ == param1 && _loc4_ == param2)
               {
                  FRoleVect.splice(_loc3_,1);
                  TPoolBitmap.SaveBitmap(_loc7_);
                  return;
               }
            }
            _loc3_++;
         }
      }
      
      public static function RemoveContainerEffect(param1:DisplayObjectContainer) : void
      {
         var _loc2_:int = 0;
         var _loc3_:Vector.<Object> = null;
         var _loc4_:DisplayObjectContainer = null;
         var _loc5_:Bitmap = null;
         _loc2_ = 0;
         while(_loc2_ < FRoleVect.length)
         {
            _loc3_ = FRoleVect[_loc2_];
            if(_loc3_ != null)
            {
               _loc4_ = _loc3_[EFFECT_TARGET] as DisplayObjectContainer;
               _loc5_ = _loc3_[EFFECT_BMP] as Bitmap;
               if(_loc4_ == param1)
               {
                  FRoleVect.splice(_loc2_,1);
                  TPoolBitmap.SaveBitmap(_loc5_);
               }
            }
            _loc2_++;
         }
      }
      
      public static function RemovePublicEffect(param1:DisplayObjectContainer, param2:uint = 0) : void
      {
         var _loc3_:int = 0;
         var _loc4_:uint = 0;
         var _loc5_:Vector.<Object> = null;
         var _loc6_:DisplayObjectContainer = null;
         var _loc7_:Bitmap = null;
         _loc3_ = 0;
         while(_loc3_ < FPublicEffectVect.length)
         {
            _loc5_ = FPublicEffectVect[_loc3_];
            if(_loc5_ != null)
            {
               _loc6_ = _loc5_[EFFECT_PUBLIC_TARGET] as DisplayObjectContainer;
               _loc4_ = _loc5_[EFFECT_PUBLIC_RESOURCE_ID] as uint;
               _loc7_ = _loc5_[EFFECT_PUBLIC_BMP] as Bitmap;
               if(_loc6_ == param1 && _loc4_ == param2)
               {
                  FPublicEffectVect.splice(_loc3_,1);
                  TPoolBitmap.SaveBitmap(_loc7_);
                  return;
               }
            }
            _loc3_++;
         }
      }
      
      public static function RemoveContainerPublicEffect(param1:DisplayObjectContainer) : void
      {
         var _loc2_:int = 0;
         var _loc3_:uint = 0;
         var _loc4_:Vector.<Object> = null;
         var _loc5_:DisplayObjectContainer = null;
         var _loc6_:Bitmap = null;
         _loc2_ = 0;
         while(_loc2_ < FPublicEffectVect.length)
         {
            _loc4_ = FPublicEffectVect[_loc2_];
            if(_loc4_ != null)
            {
               _loc5_ = _loc4_[EFFECT_PUBLIC_TARGET] as DisplayObjectContainer;
               _loc3_ = _loc4_[EFFECT_PUBLIC_RESOURCE_ID] as uint;
               _loc6_ = _loc4_[EFFECT_PUBLIC_BMP] as Bitmap;
               if(_loc5_ == param1)
               {
                  FPublicEffectVect.splice(_loc2_,1);
                  TPoolBitmap.SaveBitmap(_loc6_);
               }
            }
            _loc2_++;
         }
      }
      
      public static function RemoveAllEffect() : void
      {
         var _loc1_:Vector.<Object> = null;
         var _loc2_:Bitmap = null;
         while(FRoleVect.length)
         {
            _loc1_ = FRoleVect.pop();
            if(_loc1_ != null)
            {
               _loc2_ = _loc1_[EFFECT_BMP] as Bitmap;
               TPoolBitmap.SaveBitmap(_loc2_);
            }
         }
      }
      
      public static function RemoveAllSpecialChainEffect() : void
      {
         var _loc1_:Vector.<Object> = null;
         var _loc2_:Vector.<Sprite> = null;
         var _loc3_:Sprite = null;
         var _loc4_:Bitmap = null;
         while(FRoleSpecialChainVect.length)
         {
            _loc1_ = FRoleSpecialChainVect.pop();
            if(_loc1_ != null)
            {
               _loc2_ = _loc1_[EFFECT_SPECIALCHAIN_SPRITELIST] as Vector.<Sprite>;
               while(_loc2_.length)
               {
                  _loc3_ = _loc2_.pop();
                  _loc4_ = _loc3_.getChildAt(0) as Bitmap;
                  TPoolBitmap.SaveBitmap(_loc4_);
               }
            }
         }
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
      
      public static function UpdataRoleEffect() : void
      {
         var _loc1_:int = 0;
         var _loc2_:int = 0;
         var _loc3_:int = 0;
         var _loc4_:BitmapData = null;
         var _loc5_:Object = null;
         var _loc6_:Vector.<Object> = null;
         var _loc7_:DisplayObjectContainer = null;
         var _loc8_:uint = 0;
         var _loc9_:int = 0;
         var _loc10_:Object = null;
         var _loc11_:TRole = null;
         var _loc12_:TRole = null;
         var _loc13_:Vector.<TRole> = null;
         var _loc14_:Vector.<TTargetInfo> = null;
         var _loc15_:Number = NaN;
         var _loc16_:Number = NaN;
         var _loc17_:Number = NaN;
         var _loc18_:Number = NaN;
         var _loc19_:Bitmap = null;
         var _loc20_:int = 0;
         var _loc21_:Function = null;
         var _loc22_:int = 0;
         var _loc23_:int = 0;
         var _loc24_:int = 0;
         var _loc25_:int = 0;
         var _loc26_:int = 0;
         var _loc27_:TSkillEffectConfig = null;
         var _loc28_:uint = 0;
         var _loc29_:Class = null;
         var _loc30_:Number = NaN;
         var _loc31_:Number = NaN;
         var _loc32_:Number = NaN;
         var _loc33_:Number = NaN;
         var _loc34_:Boolean = false;
         var _loc35_:Boolean = false;
         _loc3_ = int(FRoleVect.length);
         _loc1_ = 0;
         for(; _loc1_ < _loc3_; _loc1_++)
         {
            _loc6_ = FRoleVect[_loc1_];
            if(_loc6_ != null)
            {
               _loc7_ = _loc6_[EFFECT_TARGET] as DisplayObjectContainer;
               _loc8_ = _loc6_[EFFECT_RESOURCE_ID] as uint;
               _loc9_ = _loc6_[EFFECT_CURINDEX] as int;
               _loc10_ = _loc6_[EFFECT_LOGIC];
               _loc11_ = _loc6_[EFFECT_SOURCE] as TRole;
               _loc12_ = _loc6_[EFFECT_INITIATOR] as TRole;
               _loc13_ = _loc6_[EFFECT_TARGETS] as Vector.<TRole>;
               _loc14_ = _loc6_[EFFECT_RESULTS] as Vector.<TTargetInfo>;
               _loc15_ = _loc6_[EFFECT_RESETPOSINT_X] as Number;
               _loc16_ = _loc6_[EFFECT_RESETPOSINT_Y] as Number;
               _loc17_ = _loc6_[EFFECT_POINT_X] as Number;
               _loc18_ = _loc6_[EFFECT_POINT_Y] as Number;
               _loc19_ = _loc6_[EFFECT_BMP] as Bitmap;
               _loc20_ = _loc6_[EFFECT_TICK] as int;
               _loc21_ = _loc6_[EFFECT_TEXTFUNCTION] as Function;
               _loc22_ = _loc6_[EFFECT_SPEED_X] as int;
               _loc23_ = _loc6_[EFFECT_SPEED_Y] as int;
               _loc24_ = _loc6_[EFFECT_MOVE_TICK] as int;
               _loc25_ = _loc6_[EFFECT_MOVE_X] as int;
               _loc26_ = _loc6_[EFFECT_MOVE_Y] as int;
               _loc27_ = _loc6_[EFFECT_CONFIGINFO] as TSkillEffectConfig;
               if(_loc27_.Timing > 1)
               {
                  _loc20_ %= _loc27_.TotleDuration;
                  FRoleVect[_loc1_][EFFECT_TICK] = _loc20_;
               }
               _loc28_ = GetAnimationFrameByTick(_loc20_,_loc27_);
               if(_loc9_ != _loc28_)
               {
                  _loc9_ = int(_loc28_);
                  FRoleVect[_loc1_][EFFECT_CURINDEX] = _loc28_;
                  if(_loc9_ != 999)
                  {
                     _loc29_ = TUtilityReflection.GetClass(STRING_COMMON.COMMON_ResKey + _loc8_ + "_" + _loc9_) as Class;
                  }
                  else
                  {
                     _loc29_ = null;
                  }
                  if(_loc29_ != null)
                  {
                     _loc4_ = new _loc29_();
                     if(_loc19_.bitmapData != _loc4_)
                     {
                        if((_loc8_ == 13610004 || _loc8_ == 13610005) && _loc9_ == 0)
                        {
                           _loc30_ = 5 - Math.random() * 10;
                           _loc31_ = 5 - Math.random() * 10;
                           _loc17_ += _loc30_;
                           _loc18_ += _loc31_;
                           FRoleVect[_loc1_][EFFECT_POINT_X] += _loc30_;
                           FRoleVect[_loc1_][EFFECT_POINT_Y] += _loc31_;
                        }
                        _loc19_.bitmapData = _loc4_;
                        if(_loc19_.scaleX > 0)
                        {
                           _loc19_.x = -_loc27_.PivotX + _loc17_;
                        }
                        else
                        {
                           _loc19_.x = _loc27_.PivotX + _loc17_;
                        }
                        _loc19_.y = -_loc27_.PivotY + _loc18_;
                        if(_loc10_ != null && _loc10_.newPoint != null)
                        {
                           _loc5_ = _loc10_.newPoint[_loc9_];
                           if(_loc5_ != null)
                           {
                              if(_loc5_.target == 1)
                              {
                                 FRoleVect[_loc1_][EFFECT_POINT_X] += _loc5_.newPointX ? _loc5_.newPointX : 0;
                                 FRoleVect[_loc1_][EFFECT_POINT_Y] += _loc5_.newPointY ? _loc5_.newPointY : 0;
                                 _loc19_.x += _loc6_[EFFECT_POINT_X];
                                 _loc19_.y += _loc6_[EFFECT_POINT_Y];
                              }
                              else if(_loc5_.target == 2)
                              {
                                 _loc32_ = _loc11_.Camp == 0 ? -100 : 100;
                                 _loc19_.x = _loc5_.newPointX ? Number(_loc5_.newPointX) : CONST_BATTLE.AverageX(_loc13_,_loc11_.Camp) + _loc32_;
                                 _loc19_.y = _loc5_.newPointY ? Number(_loc5_.newPointY) : CONST_BATTLE.AverageY(_loc13_,_loc11_.Camp);
                              }
                              else if(_loc5_.target == 3)
                              {
                                 _loc19_.x += _loc15_;
                                 _loc19_.y += _loc16_;
                              }
                              else if(_loc5_.target == 4)
                              {
                                 if(_loc12_.Camp == 0)
                                 {
                                    _loc19_.x += SBattleConfig.GetPostionByCamyPos(1,6,SBattleConfig.Type_PostionX);
                                    _loc19_.y += SBattleConfig.GetPostionByCamyPos(1,6,SBattleConfig.Type_PostionY);
                                 }
                                 else
                                 {
                                    _loc19_.x += SBattleConfig.GetPostionByCamyPos(0,6,SBattleConfig.Type_PostionX);
                                    _loc19_.y += SBattleConfig.GetPostionByCamyPos(0,6,SBattleConfig.Type_PostionY);
                                 }
                              }
                              else if(_loc5_.target != 5)
                              {
                                 if(_loc5_.target == 6)
                                 {
                                    _loc19_.x = _loc5_.newPointX + _loc15_;
                                    _loc19_.y = _loc5_.newPointY + _loc16_;
                                 }
                              }
                           }
                        }
                        if(_loc10_ != null && _loc10_.backPoint != null)
                        {
                           _loc5_ = _loc10_.backPoint[_loc9_];
                           if(_loc5_ != null)
                           {
                              (_loc7_ as TRole).FightMoveBack();
                              _loc10_.backPoint[_loc9_] = null;
                           }
                        }
                     }
                  }
                  if(_loc10_ != null)
                  {
                     if(_loc10_.appendEffect != null)
                     {
                        _loc5_ = _loc10_.appendEffect[_loc9_];
                        if(_loc5_ != null)
                        {
                           if(_loc5_.target == 1)
                           {
                              if(_loc7_ is TRole)
                              {
                                 (_loc7_ as TRole).AddEffect(_loc5_,_loc11_,_loc13_,_loc14_,_loc19_.x,_loc19_.y);
                              }
                           }
                           else if(_loc5_.target == 2)
                           {
                              if(_loc13_ != null)
                              {
                                 _loc2_ = 0;
                                 for(; _loc2_ < _loc13_.length; _loc2_++)
                                 {
                                    if(_loc13_[_loc2_] == _loc11_)
                                    {
                                       if(_loc13_[_loc2_].Skilling)
                                       {
                                          if(_loc14_[_loc2_].ResultInfo.HurtAnger > 0)
                                          {
                                             continue;
                                          }
                                       }
                                       else if(_loc14_[_loc2_].ResultInfo.HurtAnger < 0)
                                       {
                                          continue;
                                       }
                                    }
                                    if(Boolean(_loc11_) && CONST_BATTLE.HasEnemy(_loc13_,_loc11_.Camp))
                                    {
                                       if(_loc13_[_loc2_].Camp != _loc11_.Camp)
                                       {
                                          _loc13_[_loc2_].AddEffect(TEffectControl.CopyObject(_loc5_),_loc11_,Vector.<TRole>([_loc13_[_loc2_]]),Vector.<TTargetInfo>([_loc14_[_loc2_]]),_loc19_.x,_loc19_.y,false);
                                          if(_loc14_[_loc2_].ResultInfo.HurtAnger > 0)
                                          {
                                             _loc13_[_loc2_].AddEffect({
                                                "target":2,
                                                "effectId":CONST_BATTLE.Public_Effect_DecAngle
                                             },_loc11_,Vector.<TRole>([_loc13_[_loc2_]]),Vector.<TTargetInfo>([_loc14_[_loc2_]]),_loc19_.x,_loc19_.y);
                                          }
                                       }
                                       else
                                       {
                                          if(_loc14_[_loc2_].ResultInfo.HurtHp < 0 && _loc14_[_loc2_].HealthGaining < 100)
                                          {
                                             _loc13_[_loc2_].AddEffect({
                                                "target":2,
                                                "effectId":CONST_BATTLE.Public_Effect_AddHp,
                                                "friendhp":{"2":100}
                                             },_loc11_,Vector.<TRole>([_loc13_[_loc2_]]),Vector.<TTargetInfo>([_loc14_[_loc2_]]),_loc19_.x,_loc19_.y);
                                          }
                                          if(_loc14_[_loc2_].ResultInfo.HurtHp > 0)
                                          {
                                             _loc13_[_loc2_].AddEffect({
                                                "target":2,
                                                "effectId":CONST_BATTLE.Public_Effect_AddHp,
                                                "hurthp":{"2":100}
                                             },_loc11_,Vector.<TRole>([_loc13_[_loc2_]]),Vector.<TTargetInfo>([_loc14_[_loc2_]]),_loc19_.x,_loc19_.y);
                                          }
                                          if(_loc14_[_loc2_].ResultInfo.HurtAnger < 0 && _loc14_[_loc2_].AngerGaining < 100)
                                          {
                                             _loc13_[_loc2_].AddEffect({
                                                "target":2,
                                                "effectId":CONST_BATTLE.Public_Effect_AddAngle
                                             },_loc11_,Vector.<TRole>([_loc13_[_loc2_]]),Vector.<TTargetInfo>([_loc14_[_loc2_]]),_loc19_.x,_loc19_.y);
                                             _loc14_[_loc2_].AngerGaining = 100;
                                          }
                                       }
                                    }
                                    else
                                    {
                                       _loc13_[_loc2_].AddEffect(TEffectControl.CopyObject(_loc5_),_loc11_,Vector.<TRole>([_loc13_[_loc2_]]),Vector.<TTargetInfo>([_loc14_[_loc2_]]),_loc19_.x,_loc19_.y);
                                    }
                                 }
                              }
                           }
                           else if(_loc5_.target == 3)
                           {
                              TEffectControl.ShowEffect(_loc12_.Parent,_loc5_.effectId,_loc5_,_loc11_,_loc12_,_loc13_,_loc14_,0,0,_loc12_.x,_loc12_.y,null,0,0,0,_loc12_.Camp == 0 ? 1 : -1,_loc12_.Parent.getChildIndex(_loc12_));
                           }
                           else if(_loc5_.target == 4)
                           {
                              if(_loc12_.Camp == 0)
                              {
                                 TEffectControl.ShowEffect(_loc12_.BattleStage,_loc5_.effectId,_loc5_,_loc11_,_loc12_,_loc13_,_loc14_,0,0,CONST_COMMON.STAGE_Width,0,_loc21_,0,0,0,-1);
                              }
                              else
                              {
                                 TEffectControl.ShowEffect(_loc12_.BattleStage,_loc5_.effectId,_loc5_,_loc11_,_loc12_,_loc13_,_loc14_,0,0,0,0,_loc21_,0,0,0,1);
                              }
                           }
                           else if(_loc5_.target == 5)
                           {
                              if(_loc12_.Camp == 0)
                              {
                                 TEffectControl.ShowEffect(_loc12_.BattleStage,_loc5_.effectId,_loc5_,_loc11_,_loc12_,_loc13_,_loc14_,0,0,0,0,_loc21_,0,0,0,-1);
                              }
                              else
                              {
                                 TEffectControl.ShowEffect(_loc12_.BattleStage,_loc5_.effectId,_loc5_,_loc11_,_loc12_,_loc13_,_loc14_,0,0,CONST_COMMON.STAGE_Width,0,_loc21_);
                              }
                           }
                           else if(_loc5_.target == 8)
                           {
                              _loc12_.BattleStage.ShowWhiteSprite();
                           }
                           else if(_loc5_.target == 11)
                           {
                              if(_loc12_.Camp == 0)
                              {
                                 TEffectControl.ShowEffect(_loc12_.BattleStage,_loc5_.effectId,_loc5_,_loc11_,_loc12_,_loc13_,_loc14_,0,0,SBattleConfig.GetPostionByCamyPos(1,6,SBattleConfig.Type_PostionX),SBattleConfig.GetPostionByCamyPos(1,6,SBattleConfig.Type_PostionY),_loc21_,0,0,0,-1);
                              }
                              else
                              {
                                 TEffectControl.ShowEffect(_loc12_.BattleStage,_loc5_.effectId,_loc5_,_loc11_,_loc12_,_loc13_,_loc14_,0,0,SBattleConfig.GetPostionByCamyPos(0,6,SBattleConfig.Type_PostionX),SBattleConfig.GetPostionByCamyPos(0,6,SBattleConfig.Type_PostionY),_loc21_,0,0,0,1);
                              }
                           }
                           if(_loc5_.blackwhite != null)
                           {
                              _loc12_.BattleStage.AntiColorBlackWhite(_loc12_,Boolean(_loc5_.blackwhite));
                           }
                           if(_loc5_.ChgBg != null)
                           {
                              _loc12_.BattleStage.ChangeBg(_loc12_,_loc5_.ChgBg);
                           }
                        }
                        _loc10_.appendEffect[_loc9_] = null;
                     }
                     if(_loc10_.red)
                     {
                        if(_loc10_.red[_loc9_] != null)
                        {
                           _loc12_.BattleStage.RedAntiColor(_loc12_,Boolean(_loc10_.red[_loc9_]));
                        }
                     }
                     if(_loc10_.ChgBg)
                     {
                        if(_loc10_.ChgBg[_loc9_] != null)
                        {
                           _loc12_.BattleStage.ChangeBg(_loc12_,_loc10_.ChgBg[_loc9_]);
                        }
                     }
                     if(_loc10_.FullScreenGradient)
                     {
                        if(_loc10_.FullScreenGradient[_loc9_] != null)
                        {
                           _loc12_.BattleStage.FullScreenGradient(_loc12_,uint(_loc10_.FullScreenGradient[_loc9_].color),_loc10_.FullScreenGradient[_loc9_].time);
                           _loc10_.FullScreenGradient[_loc9_] = null;
                        }
                     }
                     if(_loc10_.voice)
                     {
                        if(_loc10_.voice[_loc9_] != null)
                        {
                           SLogicsCore.SignalPost(CONST_SIGNAL.SIGNALDESTINATION_SOUND,CONST_MUSIC.PLAY_SOUND_EFFECT,_loc10_.voice[_loc9_],true);
                           _loc10_.voice[_loc9_] = null;
                        }
                     }
                     _loc2_ = 0;
                     while(_loc2_ < _loc13_.length)
                     {
                        _loc12_ = _loc13_[_loc2_];
                        _loc34_ = Boolean((_loc14_[_loc2_].TargetStatus & CONST_BATTLE.ActiveType_Crit) != 0);
                        _loc35_ = Boolean((_loc14_[_loc2_].TargetStatus1 & CONST_BATTLE.ActiveType_Penetrate) != 0);
                        _loc12_.CheckTextEffect(_loc14_[_loc2_]);
                        if(Boolean(_loc11_) && _loc11_.Camp == _loc12_.Camp)
                        {
                           if(Boolean(_loc10_.friendhp) && Boolean(_loc10_.friendhp[_loc9_] != null) && _loc14_[_loc2_].HealthGaining < 100)
                           {
                              _loc33_ = _loc14_[_loc2_].ResultInfo.HurtHp * _loc10_.friendhp[_loc9_] / 100;
                              _loc12_.CurHealth -= _loc33_;
                              if(_loc33_ != 0)
                              {
                                 if(!SLogicsCore.Character.IsSkillShowTime)
                                 {
                                    _loc14_[_loc2_].HealthGaining += _loc10_.friendhp[_loc9_];
                                 }
                              }
                              if(_loc21_ != null)
                              {
                                 _loc21_(TBattleStage.TYPETEXT_Float,_loc12_.Camp == 0 ? -1 : 1,_loc12_.x,_loc12_.y - _loc12_.RoleHeight,"+" + Math.abs(_loc33_),_loc34_,0,16777215,0,_loc35_);
                              }
                           }
                        }
                        else if(Boolean(_loc10_.anmyhp) && _loc10_.anmyhp[_loc9_] != null)
                        {
                           if(_loc14_[_loc2_].TargetStatus & CONST_BATTLE.ActiveType_Hit)
                           {
                              if(_loc14_[_loc2_].TargetStatus & CONST_BATTLE.ActiveType_Help)
                              {
                                 _loc14_[_loc2_].TargetStatus -= CONST_BATTLE.ActiveType_Help;
                                 _loc12_.AddTextEffect(CONST_BATTLE.ActiveType_Help);
                              }
                              if(_loc14_[_loc2_].TargetStatus & CONST_BATTLE.ActiveType_ImmCtrl)
                              {
                                 _loc14_[_loc2_].TargetStatus -= CONST_BATTLE.ActiveType_ImmCtrl;
                                 _loc12_.AddTextEffect(CONST_BATTLE.ActiveType_ImmCtrl);
                              }
                              if(_loc14_[_loc2_].TargetStatus & CONST_BATTLE.ActiveType_ImmCalm)
                              {
                                 _loc14_[_loc2_].TargetStatus -= CONST_BATTLE.ActiveType_ImmCalm;
                                 _loc12_.AddTextEffect(CONST_BATTLE.ActiveType_ImmCalm);
                              }
                              _loc33_ = _loc14_[_loc2_].ResultInfo.HurtHp * _loc10_.anmyhp[_loc9_] / 100;
                              if(_loc33_ != 0)
                              {
                                 if(!SLogicsCore.Character.IsSkillShowTime)
                                 {
                                    _loc12_.CurHealth -= _loc33_;
                                 }
                                 _loc12_.ActivePlay(TActive.TYPE_ACTIVE_ATTACKED,0,null,Vector.<TTargetInfo>([_loc14_[_loc2_]]));
                                 if(_loc14_[_loc2_].TargetStatus & CONST_BATTLE.ActiveType_Block)
                                 {
                                    TEffectControl.ShowPublicEffect(_loc12_,CONST_BATTLE.Public_Effect_Smoke,0,0);
                                 }
                                 if(_loc21_ != null)
                                 {
                                    _loc21_(TBattleStage.TYPETEXT_Float,_loc12_.Camp == 0 ? -1 : 1,_loc12_.x,_loc12_.y - _loc12_.RoleHeight,String(Math.floor(_loc33_)),_loc34_,_loc14_[_loc2_].TargetStatus & CONST_BATTLE.ActiveType_Block ? CONST_BATTLE.TEXT_FIGHT_STATUS_Block : 0,16777215,0,_loc35_);
                                 }
                              }
                              if(Boolean(_loc14_[_loc2_].ReportTargetStatus & CONST_BATTLE.ActiveType_Block) && Boolean(_loc14_[_loc2_].ReportTargetStatus & CONST_BATTLE.ActiveType_BeStone))
                              {
                                 if(_loc21_ != null)
                                 {
                                    _loc21_(TBattleStage.TYPETEXT_Float,_loc12_.Camp == 0 ? -1 : 1,_loc12_.x,_loc12_.y - _loc12_.RoleHeight,String(Math.floor(_loc33_)),_loc34_,CONST_BATTLE.TEXT_FIGHT_STATUS_Block,16777215,0,_loc35_);
                                 }
                              }
                              if(Boolean(_loc10_.anmyhp.checkDie) && !(_loc14_[_loc2_].TargetStatus & CONST_BATTLE.ActiveType_Block))
                              {
                                 _loc12_.CheckDie();
                              }
                           }
                           else if(Boolean(_loc14_[_loc2_].TargetStatus & CONST_BATTLE.ActiveType_ImmCtrl) || Boolean(_loc14_[_loc2_].TargetStatus & CONST_BATTLE.ActiveType_ImmCalm))
                           {
                              if(_loc21_ != null)
                              {
                                 _loc21_(TBattleStage.TYPETEXT_Float,_loc12_.Camp == 0 ? -1 : 1,_loc12_.x,_loc12_.y - _loc12_.RoleHeight,0,false,CONST_BATTLE.TEXT_FIGHT_STATUS_Lost);
                              }
                           }
                           else if(!(_loc14_[_loc2_].TargetStatus & CONST_BATTLE.ActiveType_Punch))
                           {
                              _loc12_.ActivePlay(TActive.TYPE_ACTIVE_DODGE,0,null,null,null,0,Boolean(_loc14_[_loc2_].CMD == 0));
                           }
                           if(_loc34_)
                           {
                              if(_loc7_ is TRole)
                              {
                                 (_loc7_ as TRole).BattleStage.IsCrit = false;
                                 (_loc7_ as TRole).BattleStage.CriticalUI();
                              }
                              else if(_loc7_ is TBattleStage)
                              {
                                 (_loc7_ as TBattleStage).IsCrit = false;
                                 (_loc7_ as TBattleStage).CriticalUI();
                              }
                           }
                        }
                        _loc2_++;
                     }
                     if(Boolean(_loc10_.anmyhp) && Boolean(_loc10_.anmyhp[_loc9_]))
                     {
                        _loc10_.anmyhp[_loc9_] = null;
                     }
                     if(Boolean(_loc10_.friendhp) && Boolean(_loc10_.friendhp[_loc9_]))
                     {
                        _loc10_.friendhp[_loc9_] = null;
                     }
                  }
                  if(_loc22_ != 0 || _loc23_ != 0)
                  {
                     _loc19_.x = -_loc27_.PivotX + _loc17_ + _loc25_;
                     _loc19_.y = -_loc27_.PivotY + _loc18_ + _loc26_;
                     FRoleVect[_loc1_][EFFECT_MOVE_X] += _loc22_;
                     FRoleVect[_loc1_][EFFECT_MOVE_Y] += _loc23_;
                  }
                  if((_loc22_ > 0 || _loc23_ > 0) && _loc24_ < _loc20_)
                  {
                     _loc6_.length = 0;
                     FRoleVect.splice(_loc1_,1);
                     TPoolBitmap.SaveBitmap(_loc19_);
                     _loc3_--;
                     _loc1_--;
                     continue;
                  }
                  if(_loc29_ == null)
                  {
                     _loc6_.length = 0;
                     FRoleVect.splice(_loc1_,1);
                     TPoolBitmap.SaveBitmap(_loc19_);
                     _loc3_--;
                     _loc1_--;
                     continue;
                  }
               }
               _loc20_ += 1000 / (_loc7_.stage ? _loc7_.stage.frameRate : 33);
               FRoleVect[_loc1_][EFFECT_TICK] = _loc20_;
            }
         }
      }
      
      public static function UpdataPublicEffect() : void
      {
         var _loc1_:int = 0;
         var _loc2_:BitmapData = null;
         var _loc3_:Vector.<Object> = null;
         var _loc4_:int = 0;
         var _loc5_:DisplayObjectContainer = null;
         var _loc6_:uint = 0;
         var _loc7_:Bitmap = null;
         var _loc8_:uint = 0;
         var _loc9_:Number = NaN;
         var _loc10_:Number = NaN;
         var _loc11_:int = 0;
         var _loc12_:Function = null;
         var _loc13_:TSkillEffectConfig = null;
         var _loc14_:uint = 0;
         var _loc15_:Class = null;
         _loc4_ = int(FPublicEffectVect.length);
         _loc1_ = 0;
         while(_loc1_ < _loc4_)
         {
            _loc3_ = FPublicEffectVect[_loc1_];
            if(_loc3_ != null)
            {
               _loc5_ = _loc3_[EFFECT_PUBLIC_TARGET] as DisplayObjectContainer;
               _loc6_ = _loc3_[EFFECT_PUBLIC_RESOURCE_ID] as uint;
               _loc7_ = _loc3_[EFFECT_PUBLIC_BMP] as Bitmap;
               _loc8_ = _loc3_[EFFECT_PUBLIC_CURINDEX] as uint;
               _loc9_ = _loc3_[EFFECT_PUBLIC_POINT_X] as Number;
               _loc10_ = _loc3_[EFFECT_PUBLIC_POINT_Y] as Number;
               _loc11_ = _loc3_[EFFECT_PUBLIC_TICK] as int;
               _loc12_ = _loc3_[EFFECT_PUBLIC_CALLBACK] as Function;
               _loc13_ = _loc3_[EFFECT_PUBLIC_CONFIGINFO] as TSkillEffectConfig;
               if(_loc13_.Timing > 1)
               {
                  _loc11_ %= _loc13_.TotleDuration;
                  FPublicEffectVect[_loc1_][EFFECT_PUBLIC_TICK] = _loc11_;
               }
               _loc14_ = GetAnimationFrameByTick(_loc11_,_loc13_);
               if(_loc8_ != _loc14_)
               {
                  _loc8_ = _loc14_;
                  FPublicEffectVect[_loc1_][EFFECT_PUBLIC_CURINDEX] = _loc14_;
                  if(_loc8_ != 999)
                  {
                     _loc15_ = TUtilityReflection.GetClass(STRING_COMMON.COMMON_ResKey + _loc6_ + "_" + _loc8_) as Class;
                  }
                  else
                  {
                     _loc15_ = null;
                  }
                  if(_loc15_ != null)
                  {
                     _loc2_ = new _loc15_();
                     if(_loc7_.bitmapData != _loc2_)
                     {
                        _loc7_.bitmapData = _loc2_;
                        _loc7_.x = -_loc13_.PivotX + _loc9_;
                        _loc7_.y = -_loc13_.PivotY + _loc10_;
                     }
                  }
                  if(_loc15_ == null)
                  {
                     FPublicEffectVect.splice(_loc1_,1);
                     TPoolBitmap.SaveBitmap(_loc7_);
                     _loc4_--;
                     _loc1_--;
                     if(_loc12_ != null)
                     {
                        _loc12_();
                     }
                     return;
                  }
               }
               _loc11_ += 1000 / (_loc5_.stage ? _loc5_.stage.frameRate : 33);
               FPublicEffectVect[_loc1_][EFFECT_PUBLIC_TICK] = _loc11_;
            }
            _loc1_++;
         }
      }
      
      public static function UpdataSpecialChainEffect() : void
      {
         var _loc1_:int = 0;
         var _loc2_:int = 0;
         var _loc3_:int = 0;
         var _loc4_:int = 0;
         var _loc5_:Vector.<Object> = null;
         var _loc6_:BitmapData = null;
         var _loc7_:Bitmap = null;
         var _loc8_:Vector.<Sprite> = null;
         var _loc9_:uint = 0;
         var _loc10_:uint = 0;
         var _loc11_:uint = 0;
         var _loc12_:Vector.<TRole> = null;
         var _loc13_:Vector.<TTargetInfo> = null;
         var _loc14_:int = 0;
         var _loc15_:uint = 0;
         var _loc16_:Vector.<uint> = null;
         var _loc17_:Function = null;
         var _loc18_:TSkillEffectConfig = null;
         var _loc19_:int = 0;
         var _loc20_:TRole = null;
         var _loc21_:TTargetInfo = null;
         var _loc22_:uint = 0;
         var _loc23_:Class = null;
         _loc3_ = int(FRoleSpecialChainVect.length);
         _loc1_ = 0;
         while(_loc1_ < _loc3_)
         {
            _loc5_ = FRoleSpecialChainVect[_loc1_];
            if(_loc5_ != null)
            {
               _loc8_ = _loc5_[EFFECT_SPECIALCHAIN_SPRITELIST] as Vector.<Sprite>;
               _loc9_ = _loc5_[EFFECT_SPECIALCHAIN_RESOURCE_ID] as uint;
               _loc10_ = _loc5_[EFFECT_SPECIALCHAIN_SOUND_ID] as uint;
               _loc11_ = _loc5_[EFFECT_SPECIALCHAIN_ATTACKEFFECT] as uint;
               _loc12_ = _loc5_[EFFECT_SPECIALCHAIN_TARGETS] as Vector.<TRole>;
               _loc13_ = _loc5_[EFFECT_SPECIALCHAIN_RESULTS] as Vector.<TTargetInfo>;
               _loc14_ = _loc5_[EFFECT_SPECIALCHAIN_SHOWINDEX] as int;
               _loc15_ = _loc5_[EFFECT_SPECIALCHAIN_INDEXTICK] as uint;
               _loc16_ = _loc5_[EFFECT_SPECIALCHAIN_TICK] as Vector.<uint>;
               _loc17_ = _loc5_[EFFECT_SPECIALCHAIN_TEXTFUNCTION] as Function;
               _loc18_ = _loc5_[EFFECT_SPECIALCHAIN_CONFIGINFO] as TSkillEffectConfig;
               _loc15_ += 30;
               _loc4_ = int(_loc8_.length);
               _loc2_ = 0;
               while(_loc2_ < _loc4_)
               {
                  _loc22_ = GetAnimationFrameByTick(_loc16_[_loc2_],_loc18_);
                  if(_loc22_ != 999)
                  {
                     _loc23_ = TUtilityReflection.GetClass(STRING_COMMON.COMMON_ResKey + _loc9_ + "_" + _loc22_) as Class;
                  }
                  else
                  {
                     _loc23_ = null;
                  }
                  if(_loc23_ != null)
                  {
                     if(_loc8_[_loc2_].visible)
                     {
                        _loc6_ = new _loc23_();
                        _loc7_ = _loc8_[_loc2_].getChildAt(0) as Bitmap;
                        if(_loc7_.bitmapData != _loc6_)
                        {
                           _loc7_.bitmapData = _loc6_;
                           _loc7_.x = -_loc18_.PivotX;
                           _loc7_.y = -_loc18_.PivotY;
                        }
                        _loc16_[_loc2_] += 30;
                     }
                  }
                  _loc2_++;
               }
               FRoleSpecialChainVect[_loc1_][EFFECT_SPECIALCHAIN_TICK] = _loc16_;
               if(_loc15_ > 300)
               {
                  _loc15_ -= 300;
                  if(++_loc14_ >= _loc8_.length)
                  {
                     _loc4_ = int(_loc8_.length);
                     _loc2_ = 0;
                     while(_loc2_ < _loc4_)
                     {
                        _loc8_[_loc2_].visible = false;
                        TPoolBitmap.SaveBitmap(_loc8_[_loc2_].getChildAt(0) as Bitmap);
                        _loc2_++;
                     }
                     _loc8_.length = 0;
                     FRoleSpecialChainVect.splice(_loc1_,1);
                     return;
                  }
                  _loc8_[_loc14_].visible = true;
                  _loc20_ = _loc12_[_loc14_ + 1];
                  _loc21_ = _loc13_[_loc14_];
                  if(_loc13_[_loc14_].TargetStatus & CONST_BATTLE.ActiveType_Hit)
                  {
                     if(_loc21_.TargetStatus & CONST_BATTLE.ActiveType_Help)
                     {
                        _loc21_.TargetStatus -= CONST_BATTLE.ActiveType_Help;
                        _loc20_.AddTextEffect(CONST_BATTLE.ActiveType_Help);
                     }
                     if(_loc21_.TargetStatus & CONST_BATTLE.ActiveType_ImmCtrl)
                     {
                        _loc21_.TargetStatus -= CONST_BATTLE.ActiveType_ImmCtrl;
                        _loc20_.AddTextEffect(CONST_BATTLE.ActiveType_ImmCtrl);
                     }
                     if(_loc21_.TargetStatus & CONST_BATTLE.ActiveType_ImmCalm)
                     {
                        _loc21_.TargetStatus -= CONST_BATTLE.ActiveType_ImmCalm;
                        _loc20_.AddTextEffect(CONST_BATTLE.ActiveType_ImmCalm);
                     }
                     _loc19_ = _loc21_.ResultInfo.HurtHp;
                     if(_loc19_ != 0)
                     {
                        _loc20_.CurHealth -= _loc19_;
                        if(_loc19_ > 0)
                        {
                           _loc20_.ActivePlay(TActive.TYPE_ACTIVE_ATTACKED,0,null,Vector.<TTargetInfo>([_loc21_]));
                           TEffectControl.ShowPublicEffect(_loc20_,_loc11_,0,0);
                           SLogicsCore.SignalPost(CONST_SIGNAL.SIGNALDESTINATION_SOUND,CONST_MUSIC.PLAY_SOUND_EFFECT,_loc10_,true);
                        }
                        if(_loc21_.TargetStatus & CONST_BATTLE.ActiveType_Block)
                        {
                           TEffectControl.ShowPublicEffect(_loc20_,CONST_BATTLE.Public_Effect_Smoke,0,0);
                        }
                        if(_loc17_ != null)
                        {
                           _loc17_(TBattleStage.TYPETEXT_Float,_loc20_.Camp == 0 ? -1 : 1,_loc20_.x,_loc20_.y - _loc20_.RoleHeight,String(int(_loc19_)),_loc21_.TargetStatus & CONST_BATTLE.ActiveType_Crit,_loc21_.TargetStatus & CONST_BATTLE.ActiveType_Block ? CONST_BATTLE.TEXT_FIGHT_STATUS_Block : 0);
                        }
                     }
                     if(!(_loc21_.TargetStatus & CONST_BATTLE.ActiveType_Block))
                     {
                        _loc20_.CheckDie();
                     }
                  }
                  else if(Boolean(_loc21_.TargetStatus & CONST_BATTLE.ActiveType_ImmCtrl) || Boolean(_loc21_.TargetStatus & CONST_BATTLE.ActiveType_ImmCalm))
                  {
                     if(_loc17_ != null)
                     {
                        _loc17_(TBattleStage.TYPETEXT_Float,_loc20_.Camp == 0 ? -1 : 1,_loc20_.x,_loc20_.y - _loc20_.RoleHeight,0,false,CONST_BATTLE.TEXT_FIGHT_STATUS_Lost);
                     }
                  }
                  else if(!(_loc21_.TargetStatus & CONST_BATTLE.ActiveType_Punch))
                  {
                     _loc20_.ActivePlay(TActive.TYPE_ACTIVE_DODGE,0,null,null,null,0,Boolean(_loc21_.CMD == 0));
                  }
               }
               FRoleSpecialChainVect[_loc1_][EFFECT_SPECIALCHAIN_SHOWINDEX] = _loc14_;
               FRoleSpecialChainVect[_loc1_][EFFECT_SPECIALCHAIN_INDEXTICK] = _loc15_;
            }
            _loc1_++;
         }
      }
      
      public static function PlayFlicker(param1:DisplayObject, param2:int) : uint
      {
         var IntervalTimeId:uint = 0;
         var Filcker:Function = null;
         var Display:DisplayObject = param1;
         var TimeStamp:int = param2;
         Filcker = function():void
         {
            Display.visible = !Display.visible;
         };
         IntervalTimeId = setInterval(Filcker,TimeStamp);
         return IntervalTimeId;
      }
      
      public static function PlayShake(param1:DisplayObject, param2:int, param3:Function = null, param4:Boolean = true) : void
      {
         var NextShake:Function = null;
         var Target:DisplayObject = param1;
         var Margin:int = param2;
         var EndFun:Function = param3;
         var IsFirst:Boolean = param4;
         NextShake = function():void
         {
            PlayShake(Target,int(-Margin / 1.2),EndFun,false);
         };
         if(IsFirst)
         {
            if(FSharkDict[Target] == null)
            {
               FSharkDict[Target] = [Target.x,Target.y];
            }
            else
            {
               TweenUtil.removeTween(Target,false);
               Target.x = FSharkDict[Target][0];
               Target.y = FSharkDict[Target][1];
            }
         }
         if(Margin == 0)
         {
            if(EndFun != null)
            {
               EndFun();
            }
            if(FSharkDict[Target])
            {
               Target.x = FSharkDict[Target][0];
               Target.y = FSharkDict[Target][1];
               FSharkDict[Target] = null;
            }
            return;
         }
         TweenUtil.to(Target,0.1,{
            "x":Target.x + Margin,
            "y":Target.y + Margin,
            "onComplete":NextShake
         });
      }
      
      public static function CopyObject(param1:Object) : Object
      {
         var _loc2_:ByteArray = new ByteArray();
         _loc2_.writeObject(param1);
         _loc2_.position = 0;
         return _loc2_.readObject();
      }
   }
}

