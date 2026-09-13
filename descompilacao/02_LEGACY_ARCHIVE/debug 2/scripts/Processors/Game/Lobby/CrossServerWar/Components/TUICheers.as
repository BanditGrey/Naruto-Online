package Processors.Game.Lobby.CrossServerWar.Components
{
   import Foundation.Resources.SResourcesCore;
   import Foundation.UI.TUIComponent;
   import Foundation.Utilities.TGameUtil;
   import Logics.DatebaseVO.VO.Json.TCrossServerWarReward;
   import Logics.DatebaseVO.VO.TArticle;
   import Logics.DatebaseVO.VO.TGSPVP_DailyAward;
   import Processors.Game.TProcessorGame;
   import Resources.Constants.CONST_CROSSSERVERWAR;
   import Resources.Constants.CONST_DATEBASEVO;
   import Resources.Strings.STRING_COMMON;
   import Resources.Strings.STRING_CROSSSERVERWAR;
   import flash.display.MovieClip;
   import flash.events.MouseEvent;
   import flash.text.TextField;
   
   public class TUICheers extends TProcessorGame
   {
      
      protected var FBTN_Toast:MovieClip;
      
      protected var FTF_Reward:TextField;
      
      protected var FTF_Cost:TextField;
      
      protected var FMC_Wine:MovieClip;
      
      protected var FResource:MovieClip;
      
      protected var FContext:Object;
      
      protected var FOnToastClick:Function;
      
      public function TUICheers(param1:TUIComponent)
      {
         super(param1);
      }
      
      protected function UIDispatch() : void
      {
         this.FBTN_Toast = this.FResource[CONST_CROSSSERVERWAR.RESOURCE_Link_BTN_Toast];
         TGameUtil.setButtonMode(this.FBTN_Toast,true);
         this.FTF_Reward = this.FResource[CONST_CROSSSERVERWAR.RESOURCE_Link_TF_Reward];
         this.FTF_Cost = this.FResource[CONST_CROSSSERVERWAR.RESOURCE_Link_TF_Cost];
         this.FMC_Wine = this.FResource[CONST_CROSSSERVERWAR.RESOURCE_Link_MC_Wine];
      }
      
      protected function UILocation() : void
      {
         this.FBTN_Toast.addEventListener(MouseEvent.CLICK,this.BTNToastOnClick,false,0,true);
      }
      
      protected function UpdateUI() : void
      {
         var _loc1_:TGSPVP_DailyAward = null;
         var _loc2_:int = 0;
         var _loc3_:uint = 0;
         var _loc4_:uint = 0;
         var _loc5_:uint = 0;
         var _loc6_:uint = 0;
         var _loc7_:TCrossServerWarReward = null;
         var _loc8_:TArticle = null;
         var _loc9_:String = null;
         var _loc10_:String = null;
         _loc9_ = "";
         if(this.FContext is TGSPVP_DailyAward)
         {
            _loc1_ = this.FContext as TGSPVP_DailyAward;
            this.FTF_Cost.text = _loc1_.Cost + STRING_CROSSSERVERWAR.TYPE_Cost[_loc1_.CostType - 1];
            this.FMC_Wine.gotoAndStop(_loc1_.Type);
            _loc3_ = _loc1_.CrossServerWarRewards.length;
            _loc2_ = 0;
            while(_loc2_ < _loc3_)
            {
               _loc7_ = _loc1_.CrossServerWarRewards[_loc2_];
               _loc4_ = _loc7_.Type;
               _loc5_ = _loc7_.Code;
               _loc6_ = _loc7_.Amount;
               _loc10_ = STRING_COMMON.GetItemNameByType(_loc4_,_loc5_);
               if(_loc10_ == "")
               {
                  _loc8_ = SResourcesCore.ResourceBin.GetDatebase(CONST_DATEBASEVO.RESOURCEID_Article,_loc5_) as TArticle;
                  _loc9_ += _loc8_.Name + "+" + _loc6_ + "\n";
               }
               else
               {
                  _loc9_ += _loc10_ + "*" + _loc6_ + "\n";
               }
               _loc2_++;
            }
            this.FTF_Reward.text = _loc9_;
         }
      }
      
      protected function BTNToastOnClick(param1:MouseEvent) : void
      {
         if(this.FOnToastClick != null)
         {
            this.FOnToastClick(this,this.FContext);
         }
      }
      
      public function get Resource() : MovieClip
      {
         return this.FResource;
      }
      
      public function set Resource(param1:MovieClip) : void
      {
         this.FResource = param1;
      }
      
      public function get Context() : Object
      {
         return this.FContext;
      }
      
      public function set Context(param1:Object) : void
      {
         this.FContext = param1;
      }
      
      public function get OnToastClick() : Function
      {
         return this.FOnToastClick;
      }
      
      public function set OnToastClick(param1:Function) : void
      {
         this.FOnToastClick = param1;
      }
      
      public function Init() : void
      {
         this.UIDispatch();
         this.UILocation();
      }
      
      public function Update() : void
      {
         if(this.FContext == null)
         {
            return;
         }
         this.UpdateUI();
      }
      
      public function UpdateBtnStatus(param1:Boolean = true) : void
      {
         var _loc2_:String = null;
         TGameUtil.setButtonMode(this.FBTN_Toast,param1);
         this.FBTN_Toast.mouseEnabled = param1;
         _loc2_ = param1 ? STRING_CROSSSERVERWAR.STRING_TodayToast : STRING_CROSSSERVERWAR.STRING_HaveToasted;
         this.FBTN_Toast["TF_Toast"].text = _loc2_;
      }
   }
}

