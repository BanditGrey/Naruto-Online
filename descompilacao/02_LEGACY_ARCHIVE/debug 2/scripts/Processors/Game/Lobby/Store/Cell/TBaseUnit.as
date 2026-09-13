package Processors.Game.Lobby.Store.Cell
{
   import Components.Slots.TUISlot;
   import Foundation.Utilities.TGameUtil;
   import Foundation.Utilities.TUtilityString;
   import Logics.SLogicsCore;
   import Processors.Game.Lobby.Store.data.NewMallCellData;
   import Resources.Constants.CONST_COMMON;
   import Resources.Strings.STRING_NEWMALL;
   import Resources.Strings.STRING_OhtsutsukiKaguya;
   import flash.display.MovieClip;
   import flash.events.MouseEvent;
   import flash.text.TextField;
   
   public class TBaseUnit
   {
      
      protected static const QUALITYCOLOR_INDEX:Vector.<uint> = CONST_COMMON.QUALITYCOLOR_INDEX;
      
      protected var FThisPanel:MovieClip = null;
      
      protected var FMC_BackgroundOne:MovieClip = null;
      
      protected var FMC_Slot:MovieClip = null;
      
      protected var FTF_OriginalPrice:TextField = null;
      
      protected var FMC_HotOrNew:MovieClip = null;
      
      protected var FMC_Price:MovieClip = null;
      
      protected var FMC_KaguyaPrice:MovieClip = null;
      
      protected var FMC_VipPrice:MovieClip = null;
      
      protected var FMC_DiscountPrice:MovieClip = null;
      
      protected var FTF_GoodsName:TextField = null;
      
      protected var FMC_SelectBox:MovieClip = null;
      
      protected var FMC_Effect:MovieClip = null;
      
      protected var FMC_Middle:MovieClip = null;
      
      protected var FMSlot:TUISlot;
      
      protected var FAtState:int;
      
      protected var FCurData:NewMallCellData = null;
      
      protected var FTF_NowPrice:TextField = null;
      
      protected var FYuanProce:TextField = null;
      
      protected var FXianProce:TextField = null;
      
      protected var FMC_GoldFire:MovieClip = null;
      
      protected var FBTN_ShowRecruit:MovieClip;
      
      protected var FOnClick:Function;
      
      protected var FOnClickShowRecruit:Function;
      
      public function TBaseUnit()
      {
         super();
      }
      
      protected function InitilizationPanel() : void
      {
         this.FMC_BackgroundOne = this.FThisPanel["MC_BackgroundOne"];
         this.FMC_Slot = this.FThisPanel["MC_Slot"];
         this.FTF_OriginalPrice = this.FThisPanel["TF_OriginalPrice"];
         if(this.FTF_OriginalPrice)
         {
            this.FTF_OriginalPrice.mouseEnabled = false;
         }
         this.FMC_HotOrNew = this.FThisPanel["MC_HotOrNew"];
         if(this.FMC_HotOrNew)
         {
            this.FMC_HotOrNew.mouseEnabled = false;
         }
         this.FMC_Price = this.FThisPanel["MC_Price"];
         if(this.FMC_Price)
         {
            this.FMC_Price.mouseChildren = false;
            this.FMC_Price.mouseEnabled = false;
            this.FMC_KaguyaPrice = this.FMC_Price["MC_KaguyaPrice"];
            this.FMC_VipPrice = this.FMC_Price["MC_VipPrice"];
         }
         this.FTF_GoodsName = this.FThisPanel["TF_GoodsName"];
         this.FMC_SelectBox = this.FThisPanel["MC_SelectBox"];
         this.FMC_Effect = this.FThisPanel["MC_Effect"];
         if(this.FMC_Effect)
         {
            this.FMC_Effect.mouseChildren = false;
            this.FMC_Effect.mouseEnabled = false;
         }
         this.FMC_DiscountPrice = this.FThisPanel["MC_DiscountPrice"];
         if(this.FMC_DiscountPrice)
         {
            this.FMC_DiscountPrice.mouseEnabled = false;
            this.FMC_Middle = this.FMC_DiscountPrice["MC_Middle"];
            this.FTF_NowPrice = this.FMC_Middle["TF_NowPrice"];
         }
         this.FMC_SelectBox.visible = false;
         this.FMC_GoldFire = this.FThisPanel["MC_GoldFire"];
         if(this.FMC_GoldFire)
         {
            this.FMC_GoldFire.mouseEnabled = false;
         }
         this.FBTN_ShowRecruit = this.FThisPanel["BTN_ShowRecruit"];
         TGameUtil.setButtonMode(this.FBTN_ShowRecruit,true);
      }
      
      public function UpdateView() : void
      {
         var _loc1_:int = 0;
         this.setVisible();
         this.setNotVisible();
         this.FTF_GoodsName.text = String(this.FCurData.NewMall.Name);
         this.FTF_GoodsName.textColor = QUALITYCOLOR_INDEX[this.FCurData.Artial.Quality];
         if(this.FMC_HotOrNew)
         {
            this.FMC_HotOrNew.visible = true;
            switch(this.FCurData.NewMall.Title)
            {
               case 0:
                  this.FMC_HotOrNew.visible = false;
                  break;
               case 1:
                  this.FMC_HotOrNew.gotoAndStop(1);
                  break;
               case 2:
                  this.FMC_HotOrNew.gotoAndStop(2);
                  break;
               case 3:
                  this.FMC_HotOrNew.gotoAndStop(3);
                  break;
               case 4:
                  this.FMC_HotOrNew.gotoAndStop(4);
            }
            if(this.FMC_Effect)
            {
               if(this.FCurData.NewMall.Title == 2)
               {
                  this.FMC_Effect.play();
                  this.FMC_Effect.visible = true;
               }
               else
               {
                  this.FMC_Effect.visible = false;
                  this.FMC_Effect.gotoAndStop(1);
               }
            }
            if(this.FMC_GoldFire)
            {
               if(this.FCurData.NewMall.IsSpecialEffects == 1)
               {
                  this.FMC_GoldFire.visible = true;
                  this.FMC_GoldFire.play();
               }
               else
               {
                  this.FMC_GoldFire.gotoAndStop(1);
                  this.FMC_GoldFire.visible = false;
               }
            }
         }
         if(this.FCurData.NewMall.Type == 7 || this.FCurData.NewMall.Type == 6)
         {
            if(this.FMC_DiscountPrice)
            {
               this.FMC_DiscountPrice.visible = true;
               TextField(this.FMC_DiscountPrice["TF_OriginalPrice"]).text = this.FCurData.NewMall.OriginalPrice.toString();
               TextField(this.FMC_DiscountPrice["TF_NowPrice"]).text = this.FCurData.NewMall.Price.toString();
               MovieClip(this.FMC_DiscountPrice["Mc_Icon1"]).gotoAndStop(this.GetIcon());
               MovieClip(this.FMC_DiscountPrice["Mc_Icon2"]).gotoAndStop(this.GetIcon());
            }
            if(this.FBTN_ShowRecruit)
            {
               this.FBTN_ShowRecruit.visible = this.FCurData.NewMall.Type == 7;
            }
         }
         if(this.FCurData.NewMall.Title == 3 || this.FCurData.NewMall.Title == 4)
         {
            _loc1_ = this.FCurData.NewMall.BuyLimitArr[1] - this.FCurData.CurGoodsBuyCount;
            if(_loc1_ <= 0)
            {
               _loc1_ = 0;
            }
            this.FCurData.ToDayCanBuyCount = _loc1_;
            if(this.FTF_OriginalPrice)
            {
               this.FTF_OriginalPrice.visible = true;
               this.FTF_OriginalPrice.text = TUtilityString.Format(STRING_OhtsutsukiKaguya.XIANGOU,_loc1_);
            }
            if(this.FMC_Middle)
            {
               this.FMC_Middle.visible = true;
               this.FTF_NowPrice.text = _loc1_.toString();
            }
         }
         else
         {
            if(this.FTF_OriginalPrice)
            {
               this.FTF_OriginalPrice.visible = false;
            }
            if(this.FMC_Middle)
            {
               this.FMC_Middle.visible = false;
            }
         }
      }
      
      protected function GetIcon() : uint
      {
         var _loc1_:int = 2;
         if(this.FCurData.NewMall.Currencytype == 2)
         {
            _loc1_ = 1;
         }
         return _loc1_;
      }
      
      protected function setNotVisible() : void
      {
         var _loc1_:TextField = null;
         switch(this.FAtState)
         {
            case 0:
            case 1:
            case 2:
            case 5:
               if(this.FMC_VipPrice)
               {
                  this.FMC_Price.visible = true;
                  this.FMC_VipPrice.visible = true;
                  TextField(this.FMC_VipPrice["TF_OriginalPrice"]).text = String(this.FCurData.NewMall.Price);
                  if(this.FCurData.NewMall.VipPrice == 0)
                  {
                     TextField(this.FMC_VipPrice["TF_NowPrice"]).visible = false;
                     TextField(this.FMC_VipPrice["TF_VIPPrice"]).visible = false;
                     MovieClip(this.FMC_VipPrice["Mc_Icon2"]).visible = false;
                  }
                  else
                  {
                     TextField(this.FMC_VipPrice["TF_NowPrice"]).visible = true;
                     TextField(this.FMC_VipPrice["TF_VIPPrice"]).visible = true;
                     MovieClip(this.FMC_VipPrice["Mc_Icon2"]).visible = true;
                     TextField(this.FMC_VipPrice["TF_NowPrice"]).text = String(this.FCurData.NewMall.VipPrice);
                  }
                  MovieClip(this.FMC_VipPrice["Mc_Icon1"]).gotoAndStop(this.GetIcon());
                  MovieClip(this.FMC_VipPrice["Mc_Icon2"]).gotoAndStop(this.GetIcon());
                  if(SLogicsCore.Character.VipData.StonePecent)
                  {
                     MovieClip(this.FMC_VipPrice["MC_Bar"]).visible = true;
                  }
                  else
                  {
                     MovieClip(this.FMC_VipPrice["MC_Bar"]).visible = false;
                  }
               }
               break;
            case 3:
            case 4:
               if(this.FMC_KaguyaPrice)
               {
                  this.FMC_Price.visible = true;
                  this.FMC_KaguyaPrice.visible = true;
                  _loc1_ = this.FMC_KaguyaPrice["TF_VIPPrice"];
                  TextField(this.FMC_KaguyaPrice["TF_OriginalPrice"]).text = String(this.FCurData.NewMall.Price);
                  MovieClip(this.FMC_KaguyaPrice["Mc_Icon1"]).gotoAndStop(this.GetIcon());
                  if(this.FCurData.NewMall.ConditionArr[0] == 0 && this.FCurData.NewMall.ConditionArr[1] == 0)
                  {
                     _loc1_.visible = false;
                  }
                  else
                  {
                     _loc1_.visible = true;
                     if(this.FCurData.NewMall.ConditionArr[0] == 2)
                     {
                        _loc1_.text = TUtilityString.Format(STRING_NEWMALL.S1,this.FCurData.NewMall.ConditionArr[1]);
                     }
                     else
                     {
                        _loc1_.text = TUtilityString.Format(STRING_NEWMALL.S2,this.FCurData.NewMall.ConditionArr[1]);
                     }
                  }
               }
         }
      }
      
      public function set CurData(param1:NewMallCellData) : void
      {
         this.FCurData = param1;
         this.UpdateView();
      }
      
      public function get CurData() : NewMallCellData
      {
         return this.FCurData;
      }
      
      public function set MC_BackgroundOne(param1:MovieClip) : void
      {
         this.FMC_BackgroundOne = param1;
      }
      
      public function get MC_BackgroundOne() : MovieClip
      {
         return this.FMC_BackgroundOne;
      }
      
      public function set AtState(param1:int) : void
      {
         this.FAtState = param1;
      }
      
      public function get AtState() : int
      {
         return this.FAtState;
      }
      
      public function set ThisPanel(param1:MovieClip) : void
      {
         this.FThisPanel = param1;
         this.InitilizationPanel();
         this.FThisPanel.buttonMode = true;
         this.FThisPanel.addEventListener(MouseEvent.MOUSE_OVER,this.Eover);
         this.FThisPanel.addEventListener(MouseEvent.MOUSE_OUT,this.Eout);
         this.FThisPanel.addEventListener(MouseEvent.CLICK,this.ClickHnadle);
         this.FBTN_ShowRecruit && this.FBTN_ShowRecruit.addEventListener(MouseEvent.CLICK,this.OnShowRecruit);
      }
      
      protected function ClickHnadle(param1:MouseEvent) : void
      {
         if(this.FOnClick != null)
         {
            this.FOnClick(this.FCurData);
         }
      }
      
      public function set OnClick(param1:Function) : void
      {
         this.FOnClick = param1;
      }
      
      protected function OnShowRecruit(param1:MouseEvent) : void
      {
         param1.stopPropagation();
         if(this.FOnClickShowRecruit != null)
         {
            this.FOnClickShowRecruit(this.FCurData.NewMall.Heroid);
         }
      }
      
      public function set OnClickShowRecruit(param1:Function) : void
      {
         this.FOnClickShowRecruit = param1;
      }
      
      public function get ThisPanel() : MovieClip
      {
         return this.FThisPanel;
      }
      
      protected function Eover(param1:MouseEvent) : void
      {
         if(this.FMC_BackgroundOne)
         {
            this.FMC_BackgroundOne.gotoAndStop(2);
         }
      }
      
      protected function Eout(param1:MouseEvent) : void
      {
         if(this.FMC_BackgroundOne)
         {
            this.FMC_BackgroundOne.gotoAndStop(1);
         }
      }
      
      protected function setVisible() : void
      {
         if(this.FMC_BackgroundOne)
         {
            this.FMC_BackgroundOne.gotoAndStop(1);
         }
         if(this.FTF_OriginalPrice)
         {
            this.FTF_OriginalPrice.visible = false;
         }
         if(this.FMC_HotOrNew)
         {
            this.FMC_HotOrNew.visible = false;
         }
         if(this.FMC_Price)
         {
            this.FMC_Price.visible = false;
         }
         if(this.FMC_KaguyaPrice)
         {
            this.FMC_KaguyaPrice.visible = false;
         }
         if(this.FMC_VipPrice)
         {
            this.FMC_VipPrice.visible = false;
         }
         if(this.FMC_Effect)
         {
            this.FMC_Effect.visible = false;
         }
         if(this.FBTN_ShowRecruit)
         {
            this.FBTN_ShowRecruit.visible = false;
         }
      }
   }
}

