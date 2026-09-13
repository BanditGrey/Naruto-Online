package Processors.Game.Lobby.Exercise.NewSpringFestival.panels
{
   import Foundation.Common.TBounds;
   import Foundation.Common.TCoordinate;
   import Foundation.Queries.Textures.TQueryAnimationSequence;
   import Foundation.Resources.Repositories.TResourceRepositoryTexture;
   import Foundation.Resources.SResourcesCore;
   import Foundation.Resources.Textures.TTexture;
   import Foundation.UI.TUIComponent;
   import Foundation.Utilities.TGameUtil;
   import Foundation.Utilities.TUtilityReflection;
   import Logics.DatebaseVO.VO.TNewSpring2018Config2;
   import Logics.DatebaseVO.VO.TRoleModel;
   import Processors.Game.Lobby.Components.TUIHero;
   import Processors.Game.Lobby.Exercise.BaseActivity.Compoents.TUIBaseWindow;
   import Processors.Game.Lobby.Exercise.NewSpringFestival.TProcessorNewSpringFestival;
   import Resources.Constants.CONST_COMMON;
   import Resources.Constants.CONST_DATEBASEVO;
   import Resources.Constants.CONST_MODULES;
   import flash.display.MovieClip;
   import flash.display.Sprite;
   import flash.events.MouseEvent;
   import flash.text.TextField;
   
   public class TNewSpringPanel_2 extends TUIBaseWindow
   {
      
      private const BAG_COUNT:int = 2;
      
      private var _main:TProcessorNewSpringFestival;
      
      private var t_Value_0:TextField;
      
      private var t_Value_1:TextField;
      
      private var t_rechargeValue:TextField;
      
      private var t_commonValue:TextField;
      
      private var t_highValue:TextField;
      
      private var t_heroName:TextField;
      
      private var MC_Btn_Shop:MovieClip;
      
      private var MC_Btn_Preview_0:MovieClip;
      
      private var MC_Btn_Preview_1:MovieClip;
      
      private var mc_effect_1:MovieClip;
      
      private var mc_effect_2:MovieClip;
      
      private var MC_HeroPosition:MovieClip;
      
      protected var FUIHero:TUIHero;
      
      private var keyBoxItem:Object;
      
      public function TNewSpringPanel_2(param1:TUIComponent)
      {
         super(param1);
         this._main = param1 as TProcessorNewSpringFestival;
         this.FUIHero = new TUIHero(param1);
      }
      
      private function initUi() : void
      {
         var _loc1_:MovieClip = null;
         this.t_Value_0 = FMC_Scene["t_Value_0"] as TextField;
         this.t_Value_1 = FMC_Scene["t_Value_1"] as TextField;
         this.t_rechargeValue = FMC_Scene["t_rechargeValue"] as TextField;
         this.t_commonValue = FMC_Scene["t_commonValue"] as TextField;
         this.t_highValue = FMC_Scene["t_highValue"] as TextField;
         this.t_heroName = FMC_Scene["t_heroName"] as TextField;
         this.MC_HeroPosition = FMC_Scene["MC_HeroPosition"] as MovieClip;
         this.MC_HeroPosition.addChild(this.FUIHero);
         this.MC_Btn_Shop = FMC_Scene["MC_Btn_Shop"] as MovieClip;
         this.MC_Btn_Preview_0 = FMC_Scene["MC_Btn_Preview_0"] as MovieClip;
         this.MC_Btn_Preview_1 = FMC_Scene["MC_Btn_Preview_1"] as MovieClip;
         this.mc_effect_1 = FMC_Scene["mc_effect_1"] as MovieClip;
         this.mc_effect_2 = FMC_Scene["mc_effect_2"] as MovieClip;
         this.mc_effect_1.mouseEnabled = this.mc_effect_2.mouseEnabled = false;
         this.mc_effect_1.mouseChildren = this.mc_effect_2.mouseChildren = false;
         this.mc_effect_1.visible = this.mc_effect_2.visible = false;
         TGameUtil.setButtonMode(this.MC_Btn_Shop,true);
         TGameUtil.setButtonMode(this.MC_Btn_Preview_0,true);
         TGameUtil.setButtonMode(this.MC_Btn_Preview_1,true);
         this.MC_Btn_Shop.addEventListener(MouseEvent.CLICK,this.onOpenShopHandler);
         this.keyBoxItem = new Object();
         var _loc2_:int = 0;
         while(_loc2_ < this.BAG_COUNT)
         {
            _loc1_ = FMC_Scene["mc_bag_" + _loc2_.toString()] as MovieClip;
            _loc1_.buttonMode = true;
            this.keyBoxItem[_loc1_.name] = _loc2_;
            _loc1_.addEventListener(MouseEvent.CLICK,this.onBagClickHandler);
            _loc2_++;
         }
         this.MC_Btn_Preview_0.addEventListener(MouseEvent.CLICK,this.onClickBag0RewardsPreviewHandler);
         this.MC_Btn_Preview_1.addEventListener(MouseEvent.CLICK,this.onClickBag1RewardsPreviewHandler);
         this.FUIHero.OnQuerySequenceContext = this.HeroOnQuerySequenceContext;
         this.FUIHero.DefaultRole = TUtilityReflection.CreateDisplayObjectInstance(CONST_COMMON.RESOURCE_ClassName_MC_DefaultRoleTexture) as Sprite;
      }
      
      private function onClickBag1RewardsPreviewHandler(param1:MouseEvent) : void
      {
         this._main.tNewSpringRewardsPreview.UpdateUI(this._main.newSpring2018Data.bagRewardsPreviewConfig[1].Inventories);
         this._main.tNewSpringRewardsPreview.Visible = true;
      }
      
      private function onClickBag0RewardsPreviewHandler(param1:MouseEvent) : void
      {
         this._main.tNewSpringRewardsPreview.UpdateUI(this._main.newSpring2018Data.bagRewardsPreviewConfig[0].Inventories);
         this._main.tNewSpringRewardsPreview.Visible = true;
      }
      
      private function onBagClickHandler(param1:MouseEvent) : void
      {
         var _loc2_:MovieClip = param1.target as MovieClip;
         var _loc3_:int = int(this.keyBoxItem[_loc2_.name]);
         if(_loc3_ == 0 && this._main.newSpring2018Data.openNomalBagTimes <= 0)
         {
            return;
         }
         if(_loc3_ == 1 && this._main.newSpring2018Data.openSuperBagTimes <= 0)
         {
            return;
         }
         var _loc4_:Vector.<int> = new Vector.<int>();
         _loc4_.push(_loc3_);
         this._main.Packet_CS_AllReq(TProcessorNewSpringFestival.OPEN_BAG,_loc4_);
      }
      
      private function onOpenShopHandler(param1:MouseEvent) : void
      {
         this._main.tNewSpringShop2018.Visible = true;
         this._main.tNewSpringShop2018.UpdateUI(this._main.newSpring2018Data);
      }
      
      protected function HeroOnQuerySequenceContext(param1:Object, param2:Object, param3:TQueryAnimationSequence, param4:uint = 0) : void
      {
         var _loc5_:uint = 0;
         var _loc6_:TResourceRepositoryTexture = null;
         var _loc7_:TTexture = null;
         var _loc8_:TBounds = null;
         var _loc9_:TCoordinate = null;
         var _loc10_:TRoleModel = null;
         _loc5_ = param2 as uint;
         _loc8_ = new TBounds();
         _loc9_ = new TCoordinate();
         _loc6_ = SResourcesCore.TexturesModel;
         _loc10_ = SResourcesCore.ResourceBin.GetDatebase(CONST_DATEBASEVO.RESOURCEID_RoleModel,_loc5_) as TRoleModel;
         if(!_loc10_)
         {
            _loc10_ = SResourcesCore.ResourceBin.GetDatebase(CONST_DATEBASEVO.RESOURCEID_RoleModel,11110132) as TRoleModel;
         }
         _loc7_ = _loc6_.GetTextureByIdentifier(_loc10_.Model);
         if(_loc7_ != null)
         {
            param3.Value = _loc7_.GetAnimationSequenceByIndex(0);
            param3.Value.Evaluate(_loc9_,_loc8_);
            this.FUIHero.X = _loc8_.X;
            this.FUIHero.Y = _loc8_.Y;
         }
         else
         {
            _loc6_.LoadSecondary(_loc10_.Model,CONST_MODULES.MODULE_NinJaPractice);
            this.FUIHero.X = 0;
            this.FUIHero.Y = 0;
         }
      }
      
      override protected function Resources_UIDispatch(param1:MovieClip) : void
      {
         super.Resources_UIDispatch(param1);
      }
      
      override public function Perform_UIDispatch(param1:MovieClip) : void
      {
         super.Perform_UIDispatch(param1);
         this.initUi();
      }
      
      override public function LogicsPerform() : void
      {
         this.FUIHero.Update();
      }
      
      override public function UpdateUI() : void
      {
         this.t_rechargeValue.text = this._main.newSpring2018Data.totalRecharge.toString();
         this.t_Value_0.text = this._main.newSpring2018Data.openNomalBagTimes.toString();
         this.t_Value_1.text = this._main.newSpring2018Data.openSuperBagTimes.toString();
         if(this._main.newSpring2018Data.openNomalBagTimes > 0)
         {
            this.mc_effect_1.play();
            this.mc_effect_1.visible = true;
         }
         else
         {
            this.mc_effect_1.stop();
            this.mc_effect_1.visible = false;
         }
         if(this._main.newSpring2018Data.openSuperBagTimes > 0)
         {
            this.mc_effect_2.play();
            this.mc_effect_2.visible = true;
         }
         else
         {
            this.mc_effect_2.stop();
            this.mc_effect_2.visible = false;
         }
         var _loc1_:TNewSpring2018Config2 = this._main.tabConfig2.GetDatebaseByIdentifier(60003) as TNewSpring2018Config2;
         this.t_commonValue.text = int(_loc1_.chongzhi).toString();
         _loc1_ = this._main.tabConfig2.GetDatebaseByIdentifier(60004) as TNewSpring2018Config2;
         this.t_highValue.text = int(_loc1_.chongzhi).toString();
         _loc1_ = this._main.tabConfig2.GetDatebaseByIdentifier(60005) as TNewSpring2018Config2;
         this.FUIHero.Context = int(_loc1_.qianduan);
         this.t_heroName.text = _loc1_.name;
      }
   }
}

