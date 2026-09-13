package Processors.Game.Lobby.NijiaMystic.Components
{
   import Foundation.Resources.Bins.TBins;
   import Foundation.Resources.SResourcesCore;
   import Foundation.UI.TUIComponent;
   import Foundation.Utilities.TGameUtil;
   import Foundation.Utilities.TUtilityString;
   import Logics.DatebaseVO.VO.TNijiaMystic;
   import Resources.Constants.CONST_DATEBASEVO;
   import Resources.Constants.CONST_NIJIAMYSTIC;
   import Resources.Strings.STRING_NIJIAMYSTIC;
   import flash.display.MovieClip;
   import flash.display.Sprite;
   import flash.events.MouseEvent;
   import flash.text.TextField;
   
   public class TProcessorMysticItem extends TUIComponent
   {
      
      protected var FScene:MovieClip;
      
      protected var FMC_Over:Sprite;
      
      protected var FMC_Icon:Sprite;
      
      protected var FMC_IconEffect:Sprite;
      
      protected var FMC_IconPic:MovieClip;
      
      protected var FMC_Material:Sprite;
      
      protected var FTF_MaterialCount:TextField;
      
      protected var FMC_MaterialIcon:MovieClip;
      
      protected var FMC_MaterialEffect:MovieClip;
      
      protected var FMC_MaterialShowIcon:MovieClip;
      
      protected var FBtn_Upgrade:MovieClip;
      
      protected var FTF_UpgradeStatus:TextField;
      
      protected var FTF_Level:TextField;
      
      protected var FOccultEffectBins:TBins;
      
      protected var FNijiaMystic:TNijiaMystic;
      
      protected var FMysticIndex:uint;
      
      protected var FMaterialIndex:uint;
      
      protected var FMaterialCount:uint;
      
      protected var FUniversalMaterialCount:uint;
      
      protected var FMysticId:uint;
      
      protected var FCurMysticId:uint;
      
      protected var FIsOpen:Boolean;
      
      protected var FIsFullLevel:Boolean;
      
      protected var FOnEquipMystic:Function;
      
      protected var FOnMysticOver:Function;
      
      protected var FOnMysticOut:Function;
      
      protected var FOnUpgradeMystic:Function;
      
      protected var FOnMysticUpgrageHintMove:Function;
      
      protected var FOnMysticUpgrageHintOut:Function;
      
      public function TProcessorMysticItem(param1:TUIComponent, param2:uint, param3:uint)
      {
         super(param1);
         this.FMysticIndex = param2;
         this.FMaterialIndex = param3;
      }
      
      protected function InitScene() : void
      {
         this.FMC_Over = this.FScene[CONST_NIJIAMYSTIC.RESOURCE_MC_Over];
         this.FMC_Over.visible = false;
         this.FMC_Over.mouseEnabled = false;
         this.FMC_Icon = this.FScene[CONST_NIJIAMYSTIC.RESOURCE_MC_Icon];
         this.FMC_IconEffect = this.FMC_Icon[CONST_NIJIAMYSTIC.RESOURCE_MC_IconEffect];
         this.FMC_IconPic = this.FMC_Icon[CONST_NIJIAMYSTIC.RESOURCE_MC_Pic];
         this.FTF_Level = this.FScene[CONST_NIJIAMYSTIC.RESOURCE_TF_Level];
         this.FMC_IconPic.gotoAndStop(this.FMysticIndex + 2);
         this.FMC_IconEffect.visible = false;
         this.FMC_Icon.addEventListener(MouseEvent.CLICK,this.OnIconClick);
         this.FMC_Icon.addEventListener(MouseEvent.MOUSE_MOVE,this.OnMysticMouseMove);
         this.FMC_Icon.addEventListener(MouseEvent.ROLL_OUT,this.OnMysticMouseOut);
         this.FMC_Material = this.FScene[CONST_NIJIAMYSTIC.RESOURCE_MC_Material];
         this.FTF_MaterialCount = this.FMC_Material[CONST_NIJIAMYSTIC.RESOURCE_TF_Count];
         this.FMC_MaterialIcon = this.FMC_Material[CONST_NIJIAMYSTIC.RESOURCE_MC_MaterialIcon];
         this.FMC_MaterialEffect = this.FMC_MaterialIcon[CONST_NIJIAMYSTIC.RESOURCE_MC_Effect];
         this.FMC_MaterialEffect.visible = false;
         this.FMC_MaterialIcon.gotoAndStop(this.FMaterialIndex + 1);
         this.FBtn_Upgrade = this.FScene[CONST_NIJIAMYSTIC.RESOURCE_BTN_Upgrade];
         this.FTF_UpgradeStatus = this.FBtn_Upgrade[CONST_NIJIAMYSTIC.RESOURCE_BTN_UpgradeStatus];
         TGameUtil.setButtonMode(this.FBtn_Upgrade,true);
         this.FBtn_Upgrade.addEventListener(MouseEvent.CLICK,this.OnMysticUpgrade);
         this.FBtn_Upgrade.addEventListener(MouseEvent.MOUSE_MOVE,this.OnMysticUpgrageMove);
         this.FBtn_Upgrade.addEventListener(MouseEvent.MOUSE_OUT,this.OnMysticUpgrageOut);
         this.FOccultEffectBins = SResourcesCore.ResourceBin.GetBinsByResourceID(CONST_DATEBASEVO.RESOURCEID_NijiaMystic);
      }
      
      protected function Update() : void
      {
         var _loc1_:TNijiaMystic = null;
         this.FIsFullLevel = false;
         this.FTF_MaterialCount.text = this.FNijiaMystic.ConsumeOccultPoint.toString();
         if(this.FNijiaMystic != null)
         {
            this.FTF_Level.text = TUtilityString.Format(STRING_NIJIAMYSTIC.FORMAT_MysticLevel,this.FNijiaMystic.OccultEffectLv);
         }
         if(!this.FIsOpen)
         {
            this.FTF_UpgradeStatus.text = STRING_NIJIAMYSTIC.STRING_MysticUpgradeBtn[0];
            this.FMC_Icon.filters = [TGameUtil.bBlackFilters];
         }
         else
         {
            this.FTF_UpgradeStatus.text = STRING_NIJIAMYSTIC.STRING_MysticUpgradeBtn[1];
            this.FMC_Icon.filters = [];
         }
         this.FMC_Over.visible = Boolean(this.FCurMysticId == this.FMysticId);
         _loc1_ = this.FOccultEffectBins.GetDatebaseByIdentifier(this.FMysticId + 1) as TNijiaMystic;
         if(_loc1_ == null)
         {
            this.FIsFullLevel = true;
            this.FTF_UpgradeStatus.text = STRING_NIJIAMYSTIC.STRING_MysticUpgradeBtn[2];
         }
      }
      
      protected function OnIconClick(param1:MouseEvent) : void
      {
         if(this.FOnEquipMystic != null)
         {
            this.FOnEquipMystic(this,this.FMysticIndex);
         }
      }
      
      protected function OnMysticMouseMove(param1:MouseEvent) : void
      {
         this.FMC_IconEffect.visible = true;
         if(this.FOnMysticOver != null)
         {
            this.FOnMysticOver(this,this.FNijiaMystic);
         }
      }
      
      protected function OnMysticMouseOut(param1:MouseEvent) : void
      {
         this.FMC_IconEffect.visible = false;
         if(this.FOnMysticOut != null)
         {
            this.FOnMysticOut(this);
         }
      }
      
      protected function OnMysticUpgrade(param1:MouseEvent) : void
      {
         if(Boolean(param1.target) && !param1.target.buttonMode)
         {
            return;
         }
         if(this.FOnUpgradeMystic != null)
         {
            this.FOnUpgradeMystic(this,this.FMysticIndex);
         }
      }
      
      protected function OnMysticUpgrageMove(param1:MouseEvent) : void
      {
         var _loc2_:String = null;
         if(this.FIsFullLevel)
         {
            return;
         }
         if(!this.FIsOpen)
         {
            _loc2_ = STRING_NIJIAMYSTIC.FORMAT_MysticUpgradeTips[0];
         }
         else
         {
            _loc2_ = STRING_NIJIAMYSTIC.FORMAT_MysticUpgradeTips[1];
         }
         _loc2_ = TUtilityString.Format(_loc2_,STRING_NIJIAMYSTIC.STRING_MaterialName[this.FNijiaMystic.OccultEffectKey + 1],this.FNijiaMystic.ConsumeOccultPoint);
         if(this.FOnMysticUpgrageHintMove != null)
         {
            this.FOnMysticUpgrageHintMove(this,_loc2_);
         }
      }
      
      protected function OnMysticUpgrageOut(param1:MouseEvent) : void
      {
         if(this.FIsFullLevel)
         {
            return;
         }
         if(this.FOnMysticUpgrageHintOut != null)
         {
            this.FOnMysticUpgrageHintOut(this);
         }
      }
      
      public function get OnEquipMystic() : Function
      {
         return this.FOnEquipMystic;
      }
      
      public function set OnEquipMystic(param1:Function) : void
      {
         this.FOnEquipMystic = param1;
      }
      
      public function get OnMysticOver() : Function
      {
         return this.FOnMysticOver;
      }
      
      public function set OnMysticOver(param1:Function) : void
      {
         this.FOnMysticOver = param1;
      }
      
      public function get OnMysticOut() : Function
      {
         return this.FOnMysticOut;
      }
      
      public function set OnMysticOut(param1:Function) : void
      {
         this.FOnMysticOut = param1;
      }
      
      public function get OnUpgradeMystic() : Function
      {
         return this.FOnUpgradeMystic;
      }
      
      public function set OnUpgradeMystic(param1:Function) : void
      {
         this.FOnUpgradeMystic = param1;
      }
      
      public function get OnMysticUpgrageHintMove() : Function
      {
         return this.FOnMysticUpgrageHintMove;
      }
      
      public function set OnMysticUpgrageHintMove(param1:Function) : void
      {
         this.FOnMysticUpgrageHintMove = param1;
      }
      
      public function get OnMysticUpgrageHintOut() : Function
      {
         return this.FOnMysticUpgrageHintOut;
      }
      
      public function set OnMysticUpgrageHintOut(param1:Function) : void
      {
         this.FOnMysticUpgrageHintOut = param1;
      }
      
      public function SetScene(param1:MovieClip) : void
      {
         this.FScene = param1;
         this.InitScene();
      }
      
      public function SetData(param1:uint, param2:uint, param3:uint, param4:uint) : void
      {
         var _loc5_:TNijiaMystic = null;
         this.FMaterialCount = param1;
         this.FUniversalMaterialCount = param2;
         this.FMysticId = param3;
         this.FCurMysticId = param4;
         if(param3 % 100 == 0)
         {
            this.FNijiaMystic = this.FOccultEffectBins.GetDatebaseByIdentifier(param3) as TNijiaMystic;
            this.FIsOpen = false;
         }
         else
         {
            this.FNijiaMystic = this.FOccultEffectBins.GetDatebaseByIdentifier(param3) as TNijiaMystic;
            this.FIsOpen = true;
         }
         _loc5_ = this.FOccultEffectBins.GetDatebaseByIdentifier(param3 + 1) as TNijiaMystic;
         if(this.FNijiaMystic != null)
         {
            this.FNijiaMystic.NextNijiaMystic = _loc5_;
         }
         this.Update();
      }
   }
}

