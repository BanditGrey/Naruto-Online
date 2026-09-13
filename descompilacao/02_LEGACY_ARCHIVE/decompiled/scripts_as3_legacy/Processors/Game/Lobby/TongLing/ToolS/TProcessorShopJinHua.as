package Processors.Game.Lobby.TongLing.ToolS
{
   import Foundation.Network.SNetworkCore;
   import Foundation.Network.TPacket;
   import Foundation.Resources.Bins.TBins;
   import Foundation.Resources.SResourcesCore;
   import Foundation.UI.TUIComponent;
   import Foundation.UI.TUICore;
   import Foundation.Utilities.TGameUtil;
   import Foundation.Utilities.TUtilityReflection;
   import Logics.DatebaseVO.VO.TBB_EvoShope;
   import Processors.Game.Lobby.Common.TProcessorLobbyWindow;
   import Processors.Game.Windows.Information.TUIWindowConfirmation;
   import Rendering.Overlayers.TongLingAnimal.TongLingAttriteTip;
   import Resources.Constants.CONST_COMMON;
   import Resources.Constants.CONST_DATEBASEVO;
   import Resources.Constants.CONST_NETWORK;
   import Resources.Constants.CONST_TONGLINGANIMAL;
   import Resources.Strings.STRING_TONGLING;
   import Utilities.UI.Overlayers.TUtilityUIOverlayer;
   import Utilities.UI.Windows.TUtilityUIWindow;
   import flash.display.MovieClip;
   import flash.display.SimpleButton;
   import flash.display.Sprite;
   import flash.events.MouseEvent;
   import flash.text.TextField;
   import flash.utils.ByteArray;
   
   public class TProcessorShopJinHua extends TProcessorLobbyWindow
   {
      
      public static const COUNT_ANIMAL:Number = 3;
      
      public static var BuyAnimalCost:int = 0;
      
      protected var FRootPanel:MovieClip;
      
      protected var FOriginalDatas:Vector.<TBB_EvoShope> = new Vector.<TBB_EvoShope>();
      
      protected var FCurIndex:int = 1;
      
      protected var FAllIndex:int = 1;
      
      protected var FLeft:MovieClip;
      
      protected var FRight:MovieClip;
      
      protected var FPageText:TextField;
      
      protected var FTF_PointCount:TextField;
      
      protected var FTipShop:TongLingAttriteTip;
      
      protected var ThreeVecs:Vector.<ThreeAnimalUint> = new Vector.<ThreeAnimalUint>(COUNT_ANIMAL);
      
      protected var FTempCore:TUICore;
      
      protected var FCurCount:int = 0;
      
      protected var TPopWindow:TUIWindowConfirmation;
      
      protected var FPComPent:TUIComponent;
      
      protected var FCot:int;
      
      private var FSprite:Sprite = new Sprite();
      
      protected var FEvolutionPoint:uint;
      
      public function TProcessorShopJinHua(param1:TUIComponent, param2:TUICore)
      {
         this.FPComPent = param1;
         this.FTempCore = param2;
         super(param1);
      }
      
      override protected function ResourcesPerform_UIRequest() : void
      {
         SResourcesCore.TexturesSwfLobby.LoadPrimary(CONST_TONGLINGANIMAL.TONGLING_ID);
         super.ResourcesPerform_UIRequest();
      }
      
      public function BeginDraw() : void
      {
         this.FSprite.graphics.beginFill(0,0.3);
         this.FSprite.graphics.drawRect(0,0,this.FTempCore.StageWidth,this.FTempCore.StageHeight);
         this.FSprite.graphics.endFill();
      }
      
      override protected function ResourcesPerform_UIDispatch() : void
      {
         this.FRootPanel = TUtilityReflection.CreateDisplayObjectInstance(CONST_TONGLINGANIMAL.Shop_Count) as MovieClip;
         addChild(this.FSprite);
         this.BeginDraw();
         this.FSprite.addChild(this.FRootPanel);
         this.FSprite.x = this.FTempCore.StageWidth - this.FSprite.width >> 1;
         this.FSprite.y = this.FTempCore.StageHeight - this.FSprite.height >> 1;
         this.FRootPanel.x = this.FSprite.width - this.FRootPanel.width >> 1;
         this.FRootPanel.y = this.FSprite.height - this.FRootPanel.height >> 1;
         this.visible = false;
         this.FLeft = this.FRootPanel[CONST_TONGLINGANIMAL.Shop_Count_Page][CONST_TONGLINGANIMAL.Shop_Count_Page_L] as MovieClip;
         this.FRight = this.FRootPanel[CONST_TONGLINGANIMAL.Shop_Count_Page][CONST_TONGLINGANIMAL.Shop_Count_Page_R] as MovieClip;
         this.FPageText = this.FRootPanel[CONST_TONGLINGANIMAL.Shop_Count_Page][CONST_TONGLINGANIMAL.Shop_Count_Page_Page] as TextField;
         this.FTF_PointCount = this.FRootPanel[CONST_TONGLINGANIMAL.Shop_Count_Point] as TextField;
         TGameUtil.setButtonMode(this.FLeft,true);
         TGameUtil.setButtonMode(this.FRight,true);
         this.FLeft.addEventListener(MouseEvent.CLICK,this.ClickEvent);
         this.FRight.addEventListener(MouseEvent.CLICK,this.ClickEvent);
         SimpleButton(this.FRootPanel[CONST_TONGLINGANIMAL.Shop_Count_close]).addEventListener(MouseEvent.CLICK,this.cloHandle);
         this.FTipShop = new TongLingAttriteTip(this);
         this.FTipShop.visible = false;
         TUtilityUIOverlayer.ResourcesDispatch(this.FTipShop);
         this.TPopWindow = new TUIWindowConfirmation(this.FPComPent);
         this.TPopWindow.OnOK = this.PopWindowOnOk;
         this.TPopWindow.x = CONST_COMMON.STAGE_Width - this.TPopWindow.WindowWidth >> 1;
         this.TPopWindow.y = CONST_COMMON.STAGE_Height - this.TPopWindow.WindowHeight >> 1;
         TUtilityUIWindow.SetupWindowConfirmation(this.TPopWindow);
         this.TPopWindow.visible = false;
         super.ResourcesPerform_UIDispatch();
      }
      
      override protected function ResourcesPerform_UILocations() : void
      {
         this.GetMesArr();
         this.Valuation();
         this.SetPage();
         this.SetBtnState();
         super.ResourcesPerform_UILocations();
      }
      
      protected function Valuation() : void
      {
         var _loc2_:int = 0;
         var _loc1_:int = 0;
         _loc1_ = 0;
         while(_loc1_ < COUNT_ANIMAL)
         {
            _loc2_ = (this.FCurIndex - 1) * COUNT_ANIMAL + _loc1_;
            if(_loc2_ < this.FOriginalDatas.length)
            {
               this.ThreeVecs[_loc1_].SetMsg(this.FOriginalDatas[_loc2_]);
            }
            else
            {
               this.ThreeVecs[_loc1_].SetMsg(null);
            }
            _loc1_++;
         }
      }
      
      public function Updates() : void
      {
         var _loc1_:int = 0;
         while(_loc1_ < this.ThreeVecs.length)
         {
            if(this.ThreeVecs[_loc1_] == null)
            {
               return;
            }
            this.ThreeVecs[_loc1_].update();
            _loc1_++;
         }
      }
      
      protected function GetMesArr() : void
      {
         var _loc2_:TBins = null;
         var _loc4_:TBB_EvoShope = null;
         var _loc6_:ThreeAnimalUint = null;
         var _loc1_:int = 0;
         _loc2_ = SResourcesCore.ResourceBin.GetBinsByResourceID(CONST_DATEBASEVO.RESOURCEID_BB_EvoShope);
         var _loc3_:Number = Number(_loc2_.Count);
         while(_loc1_ < _loc3_)
         {
            _loc4_ = _loc2_.GetDatebaseByIndex(_loc1_) as TBB_EvoShope;
            this.FOriginalDatas[_loc1_] = _loc4_;
            _loc1_++;
         }
         var _loc5_:int = int(this.FOriginalDatas.length);
         this.FAllIndex = Math.ceil(_loc5_ / COUNT_ANIMAL);
         _loc1_ = 0;
         while(_loc1_ < COUNT_ANIMAL)
         {
            _loc6_ = new ThreeAnimalUint(this.FRootPanel[CONST_TONGLINGANIMAL.Shop_Count_Animal]["threeAnimal_son0" + _loc1_]);
            this.ThreeVecs[_loc1_] = _loc6_;
            _loc6_.BtnClick = this.BtnClick;
            _loc6_.OutFunction = this.OutClick;
            _loc6_.OverFunction = this.OverClick;
            _loc6_.MoverFunction = this.moveClick;
            _loc1_++;
         }
      }
      
      public function PopWindowOnOk(param1:Object) : void
      {
         var _loc2_:TPacket = null;
         var _loc3_:ByteArray = null;
         _loc2_ = SNetworkCore.PacketAcquire(CONST_NETWORK.PACKETID_CS_TongLingDianBuy_Rep);
         _loc3_ = _loc2_.Data;
         _loc3_.writeUnsignedInt(this.FCot);
         SNetworkCore.Transceiver.PacketTransmit(_loc2_);
      }
      
      public function BtnClick(param1:int, param2:int) : void
      {
         var _loc3_:Array = STRING_TONGLING.TONGLING_15.split("&");
         this.FCot = param1;
         BuyAnimalCost = param2;
         this.TPopWindow.Text = _loc3_[0] + param2 + _loc3_[1];
         this.TPopWindow.visible = true;
      }
      
      public function set count(param1:int) : void
      {
         this.FCurCount = param1;
      }
      
      public function ClickEvent(param1:MouseEvent) : void
      {
         switch(param1.currentTarget)
         {
            case this.FLeft:
               if(this.FCurIndex > 1)
               {
                  --this.FCurIndex;
                  this.Valuation();
                  this.SetPage();
                  this.SetBtnState();
               }
               break;
            case this.FRight:
               if(this.FCurIndex < this.FAllIndex)
               {
                  ++this.FCurIndex;
                  this.Valuation();
                  this.SetPage();
                  this.SetBtnState();
               }
         }
      }
      
      public function SetPage() : void
      {
         if(this.FCurIndex > this.FAllIndex)
         {
            this.FAllIndex = this.FCurIndex;
         }
         this.FPageText.text = this.FCurIndex + "/" + this.FAllIndex;
      }
      
      public function OutClick() : void
      {
         this.FTipShop.Hide();
      }
      
      public function OverClick(param1:int) : void
      {
         var _loc2_:Object = {
            "id":param1,
            "index":1
         };
         this.FTipShop.Context = _loc2_;
         this.FTipShop.Render(this.FTempCore.MouseCoordinate);
         this.FTipShop.Show();
      }
      
      public function moveClick(param1:MouseEvent) : void
      {
         if(this.FTipShop.Context == null)
         {
            return;
         }
         this.FTipShop.x = mouseX;
         this.FTipShop.y = mouseY;
      }
      
      public function cloHandle(param1:MouseEvent) : void
      {
         this.visible = false;
      }
      
      protected function SetBtnState() : void
      {
         if(this.FAllIndex <= 1)
         {
            TGameUtil.setButtonMode(this.FLeft,false);
            TGameUtil.setButtonMode(this.FRight,false);
         }
         else
         {
            TGameUtil.setButtonMode(this.FLeft,this.FCurIndex == 1 ? false : true);
            TGameUtil.setButtonMode(this.FRight,this.FCurIndex >= this.FAllIndex ? false : true);
         }
      }
      
      override public function set Visible(param1:Boolean) : void
      {
         super.Visible = param1;
         if(param1)
         {
            if(this.FTF_PointCount != null)
            {
               this.FTF_PointCount.text = this.FEvolutionPoint.toString();
            }
         }
      }
      
      public function SetPoint(param1:uint) : void
      {
         this.FEvolutionPoint = param1;
         if(this.FTF_PointCount != null)
         {
            this.FTF_PointCount.text = this.FEvolutionPoint.toString();
         }
      }
   }
}

