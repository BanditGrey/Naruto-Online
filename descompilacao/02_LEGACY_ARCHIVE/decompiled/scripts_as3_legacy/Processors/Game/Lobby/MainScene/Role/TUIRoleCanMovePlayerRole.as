package Processors.Game.Lobby.MainScene.Role
{
   import Foundation.Resources.*;
   import Foundation.Resources.Textures.*;
   import Foundation.UI.*;
   import Foundation.Utilities.TGameUtil;
   import Logics.Characters.MoveRole.*;
   import Logics.DatebaseVO.VO.*;
   import Resources.Constants.*;
   import flash.display.Bitmap;
   import flash.display.Sprite;
   import flash.events.MouseEvent;
   import flash.text.*;
   
   public class TUIRoleCanMovePlayerRole extends TUIRoleCanMove
   {
      
      protected static const MILITARY_COLOR:uint = 16435253;
      
      protected static const OFFSET_Title:uint = 20;
      
      protected static const OFFSET_BADGE:uint = 10;
      
      protected static const BADGE_COUNT:int = 9;
      
      protected static const BADGE_WEIGHT:int = 22;
      
      protected static const BADGE_HEIGHT:int = 22;
      
      protected static const TOTAL_BADGE:int = 9;
      
      protected var FMilitaryName:TextField;
      
      protected var FMilitaryFormat:TextFormat;
      
      protected var FRoleData:TRoleCanControl;
      
      protected var FPet:TUIRoleCanMovePet;
      
      protected var FChangeShape:Boolean;
      
      protected var FNewShapeBaseHeroID:uint;
      
      protected var FTitleSprite:Sprite;
      
      protected var FTitleBitmap:Bitmap;
      
      protected var FTitleID:uint;
      
      protected var FLittlePetSprite:Sprite;
      
      protected var FLittlePetBitmap:Bitmap;
      
      protected var FLittlePetID:uint;
      
      protected var FBadgeSprite:Sprite;
      
      protected var FBadgeBitmap:Vector.<Bitmap>;
      
      protected var FBadgeID:Vector.<int>;
      
      protected var FOnClicked:Function;
      
      public function TUIRoleCanMovePlayerRole(param1:TUIComponent)
      {
         var _loc2_:int = 0;
         var _loc3_:Bitmap = null;
         super(param1);
         this.FMilitaryName = new TextField();
         this.FMilitaryName.autoSize = TextFieldAutoSize.CENTER;
         this.FMilitaryName.selectable = false;
         this.FMilitaryFormat = new TextFormat();
         this.FMilitaryName.filters = NameFilters;
         addChild(this.FMilitaryName);
         this.FTitleSprite = new Sprite();
         this.FTitleBitmap = new Bitmap();
         addChild(this.FTitleSprite);
         this.FTitleSprite.addChild(this.FTitleBitmap);
         this.FTitleSprite.mouseEnabled = false;
         this.FTitleSprite.mouseChildren = false;
         this.FTitleID = 0;
         this.FLittlePetSprite = new Sprite();
         this.FLittlePetBitmap = new Bitmap();
         addChild(this.FLittlePetSprite);
         this.FLittlePetSprite.addChild(this.FLittlePetBitmap);
         this.FLittlePetSprite.mouseEnabled = false;
         this.FLittlePetSprite.mouseChildren = false;
         this.FLittlePetID = 0;
         this.FBadgeSprite = new Sprite();
         this.FBadgeBitmap = new Vector.<Bitmap>();
         addChild(this.FBadgeSprite);
         _loc2_ = 0;
         while(_loc2_ < TOTAL_BADGE)
         {
            this.FBadgeBitmap[_loc2_] = new Bitmap();
            this.FBadgeSprite.addChild(this.FBadgeBitmap[_loc2_]);
            _loc2_++;
         }
         this.FBadgeSprite.mouseEnabled = false;
         this.FBadgeSprite.mouseChildren = false;
         this.FBadgeID = new Vector.<int>();
         addChild(FTextFiledName);
         buttonMode = true;
      }
      
      protected function InitMilitaryRank() : void
      {
         var _loc1_:TMilitary = null;
         this.FMilitaryFormat.bold = true;
         this.FMilitaryFormat.font = CONST_FONTLIBRARY.NormalFounts;
         this.FMilitaryName.setTextFormat(this.FMilitaryFormat);
         _loc1_ = SResourcesCore.ResourceBin.GetDatebase(CONST_DATEBASEVO.RESOURCEID_Military,this.FRoleData.MilitaryRank) as TMilitary;
         this.FMilitaryName.text = _loc1_.Name;
         this.FMilitaryName.y = FTextFiledName.y - this.FMilitaryName.height;
         this.FMilitaryName.textColor = MILITARY_COLOR;
      }
      
      protected function InitRoleName() : void
      {
         FTextFiledNameFormat.font = CONST_FONTLIBRARY.NormalFounts;
         FTextFiledName.setTextFormat(FTextFiledNameFormat);
         FTextFiledName.text = this.FRoleData.RoleName;
         FTextFiledName.y = -FTextFiledName.height;
         if(this.RoleData.Quality >= 7)
         {
            this.RoleData.Quality = 6;
         }
         FTextFiledName.textColor = CONST_COMMON.QUALITYCOLOR_INDEX[this.RoleData.Quality];
      }
      
      protected function InitTitle() : void
      {
         this.FTitleID = this.FRoleData.TitleID;
         this.FTitleSprite.y = FTextFiledName.y - OFFSET_Title;
      }
      
      protected function InitLittlePet() : void
      {
         this.FLittlePetID = this.FRoleData.LittlePetID;
         this.FLittlePetSprite.y = -50;
         this.FLittlePetSprite.x = FCurrentFrame.Pivot.X;
      }
      
      protected function InitWing() : void
      {
         TransformID = this.FRoleData.TransformID;
         HideWing = this.FRoleData.HideWing;
      }
      
      protected function InitJade() : void
      {
         JadeID = this.FRoleData.JadeID;
      }
      
      protected function InitBadge() : void
      {
         var _loc1_:int = 0;
         var _loc2_:int = 0;
         this.FBadgeID = this.FRoleData.BadgeList;
         this.FBadgeSprite.y = this.FTitleSprite.y + OFFSET_BADGE;
      }
      
      protected function UpdateTextFieldPosition() : void
      {
         UpdateDisplayObjectPosition(FTextFiledName);
         UpdateDisplayObjectPosition(this.FMilitaryName);
         UpdateDisplayObjectPosition(this.FTitleSprite);
         UpdateOtherAnimation(this.FLittlePetSprite);
         UpdateDisplayObjectPosition(this.FBadgeSprite);
      }
      
      override protected function DoArriveTargetPosition() : void
      {
         super.DoArriveTargetPosition();
         ChangeRoleState(CONST_MainScene.INDEX_IDLE);
      }
      
      protected function UpdateTitleEffect() : void
      {
         if(this.FTitleID != 0)
         {
            TGameUtil.ShowAnimationByID(TGameUtil.Type_UserTitle,this.FTitleBitmap,FModuleId,this.FTitleID);
            this.FMilitaryName.visible = false;
         }
         else
         {
            this.FMilitaryName.visible = true;
            if(this.FTitleBitmap.bitmapData != null)
            {
               this.FTitleBitmap.bitmapData = null;
            }
         }
      }
      
      protected function UpdateLittlePetEffect() : void
      {
         if(this.FLittlePetID != 0)
         {
            TGameUtil.ShowAnimationByID(TGameUtil.Type_LittlePet,this.FLittlePetBitmap,FModuleId,this.FLittlePetID);
         }
         else if(this.FLittlePetBitmap.bitmapData != null)
         {
            this.FLittlePetBitmap.bitmapData = null;
         }
      }
      
      protected function UpdateBadgeEffect() : void
      {
         var _loc1_:int = 0;
         var _loc2_:int = 0;
         var _loc3_:int = 0;
         if(this.FTitleID == 0)
         {
            this.FBadgeSprite.y = FTextFiledName.y - OFFSET_BADGE - 30;
         }
         else
         {
            this.FBadgeSprite.y = this.FTitleSprite.y - OFFSET_BADGE + 10;
         }
         if(this.FBadgeID.length != 0)
         {
            _loc1_ = 0;
            while(_loc1_ < 1)
            {
               _loc2_ = 0;
               while(_loc2_ < BADGE_COUNT)
               {
                  _loc3_ = _loc2_ + _loc1_ * BADGE_COUNT;
                  if(_loc3_ < this.FBadgeID.length)
                  {
                     TGameUtil.ShowAnimationByID(TGameUtil.Type_Badge,this.FBadgeBitmap[_loc3_],FModuleId,this.FBadgeID[_loc3_]);
                     this.FBadgeBitmap[_loc3_].x = _loc2_ * BADGE_WEIGHT;
                     this.FBadgeBitmap[_loc3_].y = _loc1_ * BADGE_HEIGHT;
                  }
                  else
                  {
                     this.FBadgeBitmap[_loc3_].bitmapData = null;
                  }
                  _loc2_++;
               }
               _loc1_++;
            }
         }
         else
         {
            _loc1_ = 0;
            while(_loc1_ < this.FBadgeBitmap.length)
            {
               if(this.FBadgeBitmap[_loc1_].bitmapData != null)
               {
                  this.FBadgeBitmap[_loc1_].bitmapData = null;
               }
               _loc1_++;
            }
         }
      }
      
      override protected function HandleOnMouseOver(param1:MouseEvent) : void
      {
         this.filters = FFilters;
      }
      
      override protected function HandleOnMouseOut(param1:MouseEvent) : void
      {
         this.filters = null;
      }
      
      override protected function HandleOnMouseClick(param1:MouseEvent) : void
      {
         if(this.FOnClicked != null)
         {
            this.FOnClicked(this);
         }
         param1.stopImmediatePropagation();
      }
      
      public function get RoleData() : TRoleCanControl
      {
         return this.FRoleData;
      }
      
      public function set RoleData(param1:TRoleCanControl) : void
      {
         if(param1 != null)
         {
            param1.StubReferences.Reference(this);
         }
         this.FRoleData = param1;
      }
      
      public function get Pet() : TUIRoleCanMovePet
      {
         return this.FPet;
      }
      
      public function set Pet(param1:TUIRoleCanMovePet) : void
      {
         if(param1 != null)
         {
            param1.StubReferences.Reference(this);
         }
         this.FPet = param1;
      }
      
      public function get ChangeShape() : Boolean
      {
         return this.FChangeShape;
      }
      
      public function set ChangeShape(param1:Boolean) : void
      {
         this.FChangeShape = param1;
      }
      
      public function get NewShapeBaseHeroID() : uint
      {
         return this.FNewShapeBaseHeroID;
      }
      
      public function set NewShapeBaseHeroID(param1:uint) : void
      {
         this.FNewShapeBaseHeroID = param1;
      }
      
      public function set OnClicked(param1:Function) : void
      {
         this.FOnClicked = param1;
      }
      
      public function Assign(param1:TRoleCanControl) : void
      {
         FMapX = param1.MapX;
         FMapY = param1.MapY;
         this.FNewShapeBaseHeroID = param1.NewShapeBaseHeroID;
         this.FChangeShape = param1.ChangeShape;
         this.FRoleData.RoleTemplateID = param1.RoleTemplateID;
      }
      
      override public function UpdateData() : void
      {
         super.UpdateData();
         this.FPet.UpdateData();
      }
      
      override public function UpdateView() : void
      {
         super.UpdateView();
         this.UpdateTextFieldPosition();
         this.FPet.UpdateView();
         this.UpdateTitleEffect();
         this.UpdateLittlePetEffect();
         this.UpdateBadgeEffect();
      }
      
      override public function ChangeDirection(param1:int) : void
      {
         super.ChangeDirection(param1);
         this.UpdateTextFieldPosition();
      }
      
      public function Init() : void
      {
         this.ChangeHeroShape(this.FChangeShape,this.FNewShapeBaseHeroID);
         this.InitRoleName();
         this.InitMilitaryRank();
         this.InitTitle();
         this.InitLittlePet();
         this.InitWing();
         this.InitBadge();
         this.InitJade();
         this.UpdateTextFieldPosition();
      }
      
      override public function Release() : void
      {
         super.Release();
         parent.removeChild(this);
         this.Pet.Release();
         this.Pet = null;
         this.RoleData.StubReferences.Dereference(this);
         this.RoleData = null;
      }
      
      public function Reset() : void
      {
         super.Release();
         this.Pet.Reset();
      }
      
      public function ChangeHeroShape(param1:Boolean, param2:uint) : void
      {
         var _loc3_:TRoleModel = null;
         var _loc4_:TBaseHero = null;
         var _loc5_:uint = 0;
         this.FChangeShape = param1;
         if(this.FChangeShape)
         {
            this.FNewShapeBaseHeroID = param2;
            _loc5_ = param2;
         }
         else
         {
            _loc5_ = this.RoleData.RoleTemplateID;
         }
         _loc3_ = SResourcesCore.ResourceBin.GetDatebase(CONST_DATEBASEVO.RESOURCEID_RoleModel,_loc5_) as TRoleModel;
         ChangeTextureID(_loc3_.Model);
         _loc4_ = SResourcesCore.ResourceBin.GetDatebase(CONST_DATEBASEVO.RESOURCEID_BaseHero,_loc5_) as TBaseHero;
         if((Boolean(_loc4_)) && _loc4_.OffsetY != 0)
         {
            FTextFiledName.y = _loc4_.OffsetY;
            this.InitMilitaryRank();
            this.InitTitle();
            this.InitLittlePet();
            this.InitBadge();
         }
      }
      
      public function ChangePet(param1:int, param2:uint) : void
      {
         switch(param1)
         {
            case CONST_MainScene.UpdateType_UnmountPet:
               this.FPet.RelexBoo = true;
               break;
            case CONST_MainScene.UpdateType_MountPet:
               this.FPet.RelexBoo = false;
               this.FPet.TextrueID = param2;
               this.FPet.Init();
         }
      }
      
      public function ChangeWing(param1:int) : void
      {
      }
   }
}

