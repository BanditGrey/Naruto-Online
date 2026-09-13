package Processors.Game.Lobby.Exercise.BaseActivity
{
   import Foundation.Network.*;
   import Foundation.Resources.*;
   import Foundation.Resources.Bins.*;
   import Foundation.UI.*;
   import Foundation.Utilities.*;
   import Logics.*;
   import Logics.Characters.*;
   import Logics.DatebaseVO.VO.*;
   import Processors.Game.Lobby.Common.*;
   import Resources.Constants.*;
   import Resources.Strings.*;
   import flash.display.*;
   import flash.events.*;
   import flash.utils.*;
   
   public class TProcessorWindowPetDesc extends TProcessorLobbyWindow
   {
      
      protected static const QUALITYCOLOR_None:uint = 4294967295;
      
      protected static const QUALITYCOLOR_White:uint = 4294967295;
      
      protected static const QUALITYCOLOR_Green:uint = 4285071106;
      
      protected static const QUALITYCOLOR_Blue:uint = 4278228735;
      
      protected static const QUALITYCOLOR_Purple:uint = 4288217295;
      
      protected static const QUALITYCOLOR_Yellow:uint = 4294967040;
      
      protected static const QUALITYCOLOR_Red:uint = 4294836224;
      
      protected static const QUALITYCOLOR_Orange:uint = 4294901888;
      
      public static const QUALITYCOLOR_INDEX:Vector.<uint> = Vector.<uint>([QUALITYCOLOR_None,QUALITYCOLOR_White,QUALITYCOLOR_Green,QUALITYCOLOR_Blue,QUALITYCOLOR_Purple,QUALITYCOLOR_Yellow,QUALITYCOLOR_Red,QUALITYCOLOR_Orange]);
      
      public static const ATTRIBUTE_COUNT:int = 6;
      
      protected var FScene:MovieClip;
      
      protected var FPetId:uint;
      
      protected var FBB_StatusBins:TBins;
      
      protected var FBB_AttributeBins:TBins;
      
      protected var FBB_Status:TBB_Status;
      
      protected var FBB_Attribute:TBB_AttriBute;
      
      protected var FHeadIcon:uint;
      
      protected var FHeadBitmap:Bitmap;
      
      protected var FMC_LittlePetEffect:Sprite;
      
      protected var FLittlePetBmp:Bitmap;
      
      protected var FOnCloseUp:Function;
      
      public function TProcessorWindowPetDesc(param1:TUIComponent)
      {
         super(param1);
         this.FLittlePetBmp = new Bitmap();
      }
      
      override protected function ResourcesPerform_UIRequest() : void
      {
         SResourcesCore.TexturesSwfLobby.LoadPrimary(2550137121);
         super.ResourcesPerform_UIRequest();
      }
      
      override protected function ResourcesPerform_UIDispatch() : void
      {
         this.Init();
         super.ResourcesPerform_UIDispatch();
         this.FMC_LittlePetEffect = this.FScene["MC_LittlePetEffect"];
         if(this.FMC_LittlePetEffect != null)
         {
            this.FMC_LittlePetEffect.addChild(this.FLittlePetBmp);
         }
      }
      
      protected function Init() : void
      {
         this.FBB_StatusBins = SResourcesCore.ResourceBin.GetBinsByResourceID(CONST_DATEBASEVO.RESOURCEID_BB_Status);
         this.FBB_AttributeBins = SResourcesCore.ResourceBin.GetBinsByResourceID(CONST_DATEBASEVO.RESOURCEID_BB_AttriBute);
         this.FHeadBitmap = new Bitmap();
         this.FScene = TUtilityReflection.CreateDisplayObjectInstance("MC_BaseActivePetDesc") as MovieClip;
         addChild(this.FScene);
         TGameUtil.setButtonMode(this.FScene.Btn_Close,true);
         this.FScene.Btn_Close.addEventListener(MouseEvent.CLICK,this.ProcessorOnCloseUp);
         this.FScene.mc_headIcon.addChild(this.FHeadBitmap);
      }
      
      protected function UpdataUI() : void
      {
         var _loc1_:int = 0;
         var _loc2_:int = 0;
         if(this.FBB_Status == null || this.FBB_Attribute == null)
         {
            return;
         }
         this.FScene.TF_Name.text = this.FBB_Status.Name;
         this.FScene.TF_Name.textColor = QUALITYCOLOR_INDEX[this.FBB_Status.Rarity];
         this.FScene.TF_Desc.text = this.FBB_Status.Desc;
         _loc1_ = 0;
         while(_loc1_ < ATTRIBUTE_COUNT)
         {
            this.FScene["TF_Value" + _loc1_].text = this.FBB_Attribute.Lv1AddValues[_loc1_];
            this.FScene["TF_MaxValue" + _loc1_].text = this.FBB_Attribute.Lv20AddValues[_loc1_];
            _loc1_++;
         }
      }
      
      protected function ProcessorOnCloseUp(param1:MouseEvent = null) : void
      {
         Visible = false;
         if(this.FOnCloseUp != null)
         {
            this.FOnCloseUp();
         }
      }
      
      public function get OnCloseUp() : Function
      {
         return this.FOnCloseUp;
      }
      
      public function set OnCloseUp(param1:Function) : void
      {
         this.FOnCloseUp = param1;
      }
      
      public function SetPetData(param1:uint) : void
      {
         var _loc2_:TBB_Status = null;
         var _loc3_:TBB_AttriBute = null;
         if(this.FBB_StatusBins == null || this.FBB_AttributeBins == null)
         {
            this.ResourcesPerform_UIDispatch();
         }
         this.FPetId = param1;
         this.FBB_Status = this.FBB_StatusBins.GetDatebaseByIdentifier(param1) as TBB_Status;
         this.FBB_Attribute = this.FBB_AttributeBins.GetDatebaseByIdentifier(param1) as TBB_AttriBute;
         this.FHeadIcon = this.FBB_Status.SmPic;
         this.UpdataUI();
         Visible = true;
      }
      
      public function UpdataBitmap() : void
      {
         if(this.FBB_Status != null && this.FBB_Attribute != null)
         {
            this.FScene.mc_headIcon.x = 322 + (81 - this.FHeadBitmap.width) / 2;
            this.FScene.mc_headIcon.y = 31 + (71 - this.FHeadBitmap.height) / 2;
            TGameUtil.ShowImageByID(TGameUtil.Type_Pet,this.FHeadBitmap,CONST_MODULES.ACTIVE_Test,this.FBB_Status.SmPic);
         }
         this.UpdateLittlePetEffect();
      }
      
      protected function UpdateLittlePetEffect() : void
      {
         if(this.FPetId != 0)
         {
            TGameUtil.ShowImageByID(TGameUtil.Type_Pet,this.FLittlePetBmp,CONST_MODULES.ACTIVE_Test,this.FBB_Status.SmPic,2);
         }
         else
         {
            this.FLittlePetBmp.bitmapData = null;
         }
      }
   }
}

