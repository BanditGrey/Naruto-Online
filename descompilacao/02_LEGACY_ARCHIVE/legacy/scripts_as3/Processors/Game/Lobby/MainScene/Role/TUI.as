package Processors.Game.Lobby.MainScene.Role
{
   import Foundation.Resources.*;
   import Foundation.Resources.Textures.*;
   import Foundation.UI.*;
   import Foundation.Utilities.TGameUtil;
   import Logics.DatebaseVO.VO.TSpecialStone;
   import Logics.DatebaseVO.VO.TWingAdvanced;
   import Resources.Constants.*;
   import flash.display.*;
   import ghostcat.util.data.Json;
   
   public class TUI extends TUIComponent
   {
      
      public static const STATE_READY:int = -1;
      
      public static const STATE_LOADING:int = 0;
      
      public static const STATE_RUNING:int = 1;
      
      protected var FCurrentState:int;
      
      protected var FTextrueID:uint;
      
      protected var FTexture:TTexture;
      
      protected var FCurrentSequence:TAnimationSequence;
      
      protected var FCurrentFrame:TAnimationFrame;
      
      protected var FRoleBitMap:Bitmap;
      
      public var WingBitMap:Bitmap;
      
      public var WingSprite:Sprite;
      
      public var TransformID:uint;
      
      public var HideWing:uint;
      
      public var JadeID:uint;
      
      public var JadeSprite:Sprite;
      
      public var JadeBitmap:Bitmap;
      
      public var FJadeData:TSpecialStone;
      
      protected var FRoleState:int;
      
      protected var FTick:int;
      
      protected var FModuleId:uint;
      
      protected var FDirection:int;
      
      protected var FPivotXStore:int;
      
      protected var FWingStandInitX:int;
      
      protected var FWingStandInitY:int;
      
      protected var FWingFlyInitX:int;
      
      protected var FWingFlyInitY:int;
      
      protected var FWing:TWingAdvanced;
      
      protected var FOnLoadResourceOver:Function;
      
      public function TUI(param1:TUIComponent)
      {
         super(param1);
         this.WingSprite = new Sprite();
         addChild(this.WingSprite);
         this.WingBitMap = new Bitmap();
         this.WingSprite.addChild(this.WingBitMap);
         this.WingSprite.mouseEnabled = false;
         this.WingSprite.mouseChildren = false;
         this.FRoleBitMap = new Bitmap();
         addChild(this.FRoleBitMap);
         this.JadeSprite = new Sprite();
         addChild(this.JadeSprite);
         this.JadeBitmap = new Bitmap();
         this.JadeSprite.addChild(this.JadeBitmap);
         this.JadeSprite.mouseEnabled = false;
         this.JadeSprite.mouseChildren = false;
         this.FCurrentState = STATE_READY;
      }
      
      protected function UpdateModelTexture() : void
      {
         this.FTexture = SResourcesCore.TexturesModel.GetTextureByIdentifier(this.FTextrueID);
         if(this.FTexture != null)
         {
            SResourcesCore.TexturesModel.LoadSecondary(this.FTextrueID,this.FModuleId);
            this.DoAfterLoadResourceOver();
         }
         else
         {
            SResourcesCore.TexturesModel.LoadSecondary(this.FTextrueID,this.FModuleId);
         }
      }
      
      protected function UpdateModelFrame() : void
      {
         this.FTick += 1000 / FUICore.UIStage.frameRate;
         this.FCurrentFrame = this.FCurrentSequence.GetAnimationFrameByTick(this.FTick);
         if(this.FCurrentFrame == null)
         {
            return;
         }
         if(this.FRoleBitMap.bitmapData != this.FCurrentFrame.Surface)
         {
            this.FRoleBitMap.bitmapData = this.FCurrentFrame.Surface;
         }
         this.UpdateWingEffect();
         this.UpdateSpecialJadeEffect();
      }
      
      protected function ChangeModelSequenceByRoleState() : void
      {
         if(this.FTexture != null)
         {
            if(this.FTexture.Count < this.FRoleState)
            {
               this.InitBlackMan();
               this.FTexture = null;
            }
            if(this.FTexture != null && this.FRoleState < this.FTexture.Count)
            {
               this.FCurrentSequence = this.FTexture.GetAnimationSequenceByIndex(this.FRoleState);
               if(this.FCurrentFrame == null)
               {
                  this.UpdateModelFrame();
               }
               this.UpdateWingEffect();
               this.UpdateSpecialJadeEffect();
            }
         }
      }
      
      protected function DoAfterLoadResourceOver() : void
      {
         this.FCurrentState = STATE_RUNING;
         this.ChangeModelSequenceByRoleState();
         if(this.FOnLoadResourceOver != null)
         {
            this.FOnLoadResourceOver();
         }
      }
      
      protected function InitBlackMan() : void
      {
         var _loc1_:TTexture = SResourcesCore.TexturesLobby.GetTextureByIdentifier(CONST_LOBBY.RESOURCEID_Textures_DefaultRole);
         if(_loc1_ != null)
         {
            this.FCurrentSequence = _loc1_.GetAnimationSequenceByIndex(0);
            this.FCurrentFrame = this.FCurrentSequence.GetAnimationFrameByIndex(0);
            this.FRoleBitMap.bitmapData = this.FCurrentFrame.Surface;
         }
      }
      
      protected function UpdateWingEffect() : void
      {
         var _loc1_:Object = null;
         var _loc2_:Object = null;
         if(this.TransformID != 0 && this.FCurrentFrame != null && this.TextrueID <= 11100012 && this.HideWing == 2)
         {
            if(this.FCurrentFrame.Pivot.X == this.FPivotXStore)
            {
               return;
            }
            if(!this.FWing)
            {
               this.FWing = SResourcesCore.ResourceBin.GetDatebase(CONST_DATEBASEVO.RESOURCEID_WingAdvanced,this.TransformID) as TWingAdvanced;
            }
            else if(this.FWing.Identifier != this.TransformID)
            {
               this.FWing = SResourcesCore.ResourceBin.GetDatebase(CONST_DATEBASEVO.RESOURCEID_WingAdvanced,this.TransformID) as TWingAdvanced;
            }
            if(this.FWing)
            {
               _loc1_ = Json.decode(this.FWing.offset);
               _loc2_ = _loc1_[this.FTextrueID];
            }
            if(!_loc2_)
            {
               return;
            }
            if(this.FRoleState == CONST_MainScene.INDEX_RUN || this.FRoleState == CONST_MainScene.INDEX_FLY)
            {
               TGameUtil.ShowAnimationByID(TGameUtil.Type_Wing,this.WingBitMap,this.FModuleId,this.TransformID,CONST_MainScene.WING_OF_RUN);
               if(this.FDirection == CONST_MainScene.DIRECTION_RIGHT)
               {
                  this.WingBitMap.scaleX = 1;
                  this.WingBitMap.x = _loc2_.Fx;
                  this.WingBitMap.y = _loc2_.Fy;
               }
               else
               {
                  this.WingBitMap.scaleX = -1;
                  this.WingBitMap.x = -_loc2_.Fx;
                  this.WingBitMap.y = _loc2_.Fy;
               }
            }
            else
            {
               TGameUtil.ShowAnimationByID(TGameUtil.Type_Wing,this.WingBitMap,this.FModuleId,this.TransformID);
               if(this.FDirection == CONST_MainScene.DIRECTION_RIGHT)
               {
                  this.WingBitMap.scaleX = 1;
                  this.WingBitMap.x = _loc2_.Sx;
                  this.WingBitMap.y = _loc2_.Sy;
               }
               else
               {
                  this.WingBitMap.scaleX = -1;
                  this.WingBitMap.x = -_loc2_.Sx;
                  this.WingBitMap.y = _loc2_.Sy;
               }
            }
         }
         else if(this.WingBitMap.bitmapData != null)
         {
            this.WingBitMap.bitmapData = null;
         }
      }
      
      protected function UpdateSpecialJadeEffect() : void
      {
         var _loc1_:Object = null;
         var _loc2_:Object = null;
         var _loc3_:TSpecialStone = null;
         var _loc4_:int = 0;
         var _loc5_:* = 0;
         var _loc6_:int = 0;
         if(this.JadeID != 0 && this.FCurrentFrame != null)
         {
            if(!this.FJadeData)
            {
               this.FJadeData = SResourcesCore.ResourceBin.GetDatebase(CONST_DATEBASEVO.RESOURCEID_SpeicalJade,this.JadeID) as TSpecialStone;
            }
            else if(this.FJadeData.Identifier != this.JadeID)
            {
               this.FJadeData = SResourcesCore.ResourceBin.GetDatebase(CONST_DATEBASEVO.RESOURCEID_SpeicalJade,this.JadeID) as TSpecialStone;
            }
            _loc3_ = SResourcesCore.ResourceBin.GetDatebase(CONST_DATEBASEVO.RESOURCEID_SpeicalJade,this.FJadeData.NextId) as TSpecialStone;
            if(this.FRoleState == CONST_MainScene.INDEX_RUN)
            {
               _loc4_ = CONST_MainScene.SPECIALJADE_OF_RUN;
            }
            else if(this.FRoleState == CONST_MainScene.INDEX_FLY)
            {
               _loc4_ = CONST_MainScene.SPECIALJADE_OF_FLY;
            }
            else
            {
               _loc4_ = CONST_MainScene.SPECIALJADE_OF_IDLE;
            }
            _loc5_ = int(this.FJadeData.Identifier / 100000 % 10);
            if(_loc3_)
            {
               _loc5_--;
            }
            _loc6_ = int(CONST_SPECIALJADE.RESOURCE_SpecialJade_textureIDS[_loc5_]);
            TGameUtil.ShowAnimationByID(TGameUtil.Type_SpecialJade,this.JadeBitmap,CONST_MODULES.MODULE_SpeicalJade,_loc6_,_loc4_);
            if(this.FDirection == CONST_MainScene.DIRECTION_RIGHT)
            {
               this.JadeBitmap.scaleX = 1;
               this.JadeBitmap.x = -50;
               this.JadeBitmap.y = -50;
               if(this.TextrueID == 11100007 || this.TextrueID == 11100008 || this.TextrueID == 11100011 || this.TextrueID == 11100012 || this.TextrueID == 11100013 || this.TextrueID == 11100014 || this.TextrueID == 11100017 || this.TextrueID == 11100018)
               {
                  this.JadeBitmap.x = -7;
                  this.JadeBitmap.y = -32;
                  if(this.TextrueID == 11100008 || this.TextrueID == 11100014)
                  {
                     this.JadeBitmap.x = -15;
                  }
                  if(this.TextrueID == 11100011 || this.TextrueID == 11100017)
                  {
                     this.JadeBitmap.x = -17;
                  }
               }
               else if(this.TextrueID == 11100009 || this.TextrueID == 11100010 || this.TextrueID == 11100015 || this.TextrueID == 11100016)
               {
                  this.JadeBitmap.x = 12;
                  this.JadeBitmap.y = 25;
               }
            }
            else
            {
               this.JadeBitmap.scaleX = -1;
               this.JadeBitmap.x = 50;
               this.JadeBitmap.y = -50;
               if(this.TextrueID == 11100007 || this.TextrueID == 11100008 || this.TextrueID == 11100011 || this.TextrueID == 11100012 || this.TextrueID == 11100013 || this.TextrueID == 11100014 || this.TextrueID == 11100017 || this.TextrueID == 11100018)
               {
                  this.JadeBitmap.x = 7;
                  this.JadeBitmap.y = -32;
                  if(this.TextrueID == 11100008 || this.TextrueID == 11100014)
                  {
                     this.JadeBitmap.x = 15;
                  }
                  if(this.TextrueID == 11100011 || this.TextrueID == 11100017)
                  {
                     this.JadeBitmap.x = 17;
                  }
               }
               else if(this.TextrueID == 11100009 || this.TextrueID == 11100010 || this.TextrueID == 11100015 || this.TextrueID == 11100016)
               {
                  this.JadeBitmap.x = -12;
                  this.JadeBitmap.y = 25;
               }
            }
         }
         else if(this.JadeBitmap.bitmapData != null)
         {
            this.JadeBitmap.bitmapData = null;
         }
      }
      
      public function set OnLoadResourceOver(param1:Function) : void
      {
         this.FOnLoadResourceOver = param1;
      }
      
      public function get TextrueID() : uint
      {
         return this.FTextrueID;
      }
      
      public function set TextrueID(param1:uint) : void
      {
         this.FTextrueID = param1;
      }
      
      public function get CurrentFrame() : TAnimationFrame
      {
         return this.FCurrentFrame;
      }
      
      public function set ModuleId(param1:uint) : void
      {
         this.FModuleId = param1;
      }
      
      public function Update() : void
      {
         switch(this.FCurrentState)
         {
            case STATE_LOADING:
               this.UpdateModelTexture();
               break;
            case STATE_RUNING:
               this.UpdateModelFrame();
         }
      }
      
      public function ChangeRoleState(param1:int) : void
      {
         if(this.FRoleState == param1)
         {
            return;
         }
         this.FRoleState = param1;
         this.ChangeModelSequenceByRoleState();
      }
      
      public function ChangeTextureID(param1:int) : Boolean
      {
         this.FTextrueID = param1;
         this.FCurrentState = STATE_LOADING;
         this.UpdateModelTexture();
         if(this.FTexture == null)
         {
            this.InitBlackMan();
            return false;
         }
         return true;
      }
      
      public function ChangeScaleX(param1:int) : void
      {
         this.FRoleBitMap.scaleX = param1;
      }
      
      public function Release() : void
      {
         this.FTexture = null;
         this.FTextrueID = 0;
         this.FCurrentSequence = null;
         this.FCurrentFrame = null;
         this.TransformID = 0;
         this.WingBitMap.bitmapData = null;
         this.JadeBitmap.bitmapData = null;
         this.FRoleBitMap.bitmapData = null;
         this.FCurrentState = STATE_READY;
         this.FTick = 0;
      }
      
      public function Reload() : void
      {
         this.ChangeTextureID(this.FTextrueID);
      }
   }
}

