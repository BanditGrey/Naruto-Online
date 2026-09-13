package Processors.Game.Lobby.Exercise.PersiaTrader
{
   import Components.Pages.TUIPage;
   import Components.Standard.TUITab;
   import Foundation.Timing.STimingCore;
   import Foundation.UI.TUIComponent;
   import Foundation.Utilities.TGameUtil;
   import Foundation.Utilities.TUtilityDate;
   import Foundation.Utilities.TUtilityString;
   import Logics.Exercise.PersiaTrader.TPersiaTrader;
   import Logics.Exercise.TBaseBox;
   import Logics.Exercise.TBaseBoxes;
   import Logics.SLogicsCore;
   import Processors.Game.Battle.Character.TActive;
   import Processors.Game.Battle.Character.TPoolRole;
   import Processors.Game.Lobby.Exercise.BaseActivity.Compoents.TUIBaseWindow;
   import Processors.Game.Lobby.Exercise.BaseActivity.Compoents.TUIShowItem;
   import Resources.Constants.CONST_MODULES;
   import Resources.Strings.STRING_BASEACTIVITY;
   import Resources.Strings.STRING_COMMON;
   import flash.display.Bitmap;
   import flash.display.MovieClip;
   import flash.events.MouseEvent;
   
   public class TUIPersiaTrader3 extends TUIBaseWindow
   {
      
      protected static const BOX_COUNT:int = 6;
      
      protected static const BOX_COUNT_1:int = 9;
      
      public static const TAB_COUNT:int = 5;
      
      protected var FPersiaTrader:TPersiaTrader;
      
      protected var FMovieType:int;
      
      protected var FFrameCount:int;
      
      protected var FOpenIndex:int;
      
      protected var FShowList:Vector.<TUIShowItem>;
      
      protected var FShowList1:Vector.<TUIShowItem>;
      
      protected var FUIPage:TUIPage;
      
      protected var FTotalPage:int;
      
      protected var FCurPage:int;
      
      protected var FUIPage1:TUIPage;
      
      protected var FTotalPage1:int;
      
      protected var FCurPage1:int;
      
      protected var FChangeTabIndex:int;
      
      protected var FUITab:TUITab;
      
      protected var FTabVect:Vector.<MovieClip>;
      
      protected var FLittlePetBmp:Bitmap;
      
      protected var FPetId:int;
      
      protected var FHeroId:int;
      
      protected var FHeroActive:TActive;
      
      public function TUIPersiaTrader3(param1:TUIComponent)
      {
         super(param1);
         this.FPersiaTrader = SLogicsCore.PersiaTrader;
         this.FShowList = new Vector.<TUIShowItem>(BOX_COUNT);
         this.FShowList1 = new Vector.<TUIShowItem>(BOX_COUNT_1);
         this.FUIPage = new TUIPage(this);
         this.FUIPage1 = new TUIPage(this);
         this.FUITab = new TUITab(this);
         this.FTabVect = new Vector.<MovieClip>();
         this.FChangeTabIndex = 0;
         this.FLittlePetBmp = new Bitmap();
      }
      
      override protected function Resources_UIDispatch(param1:MovieClip) : void
      {
         var _loc2_:int = 0;
         var _loc3_:int = 0;
         var _loc4_:TUIShowItem = null;
         var _loc5_:MovieClip = null;
         var _loc6_:MovieClip = null;
         super.Resources_UIDispatch(param1);
         _loc2_ = 0;
         while(_loc2_ < BOX_COUNT)
         {
            _loc4_ = new TUIShowItem(this,1);
            _loc4_.Perform_UIDispatch(FMC_Scene.MC_Items["MC_Item" + _loc2_]);
            _loc4_.OnOverlay = this.SlotsOnOver;
            _loc4_.OnOut = this.SlotsOnOut;
            _loc4_.OnShowRecruit = this.ProcessorOnShowRecruit;
            this.FShowList[_loc2_] = _loc4_;
            _loc2_++;
         }
         _loc2_ = 0;
         while(_loc2_ < BOX_COUNT_1)
         {
            _loc4_ = new TUIShowItem(this,1);
            _loc4_.Perform_UIDispatch(FMC_Scene.MC_NineItems["MC_Item" + _loc2_]);
            _loc4_.OnOverlay = this.SlotsOnOver;
            _loc4_.OnOut = this.SlotsOnOut;
            _loc4_.OnShowRecruit = this.ProcessorOnShowRecruit;
            this.FShowList1[_loc2_] = _loc4_;
            _loc2_++;
         }
         this.FUIPage.ButtonPrevious.Substrate = FMC_Scene.MC_Items.MC_ChangePage.MC_PageLeft;
         this.FUIPage.ButtonNext.Substrate = FMC_Scene.MC_Items.MC_ChangePage.MC_PageRight;
         this.FUIPage.LabelPage = FMC_Scene.MC_Items.MC_ChangePage.TF_Page;
         this.FUIPage.TotalQuantity = this.FTotalPage;
         this.FUIPage.PageSize = BOX_COUNT;
         this.FUIPage.PageIndex = 0;
         this.FCurPage = 0;
         this.FUIPage.OnChangePage = this.ProcessorPageOnChange;
         this.FUIPage1.ButtonPrevious.Substrate = FMC_Scene.MC_NineItems.MC_ChangePage.MC_PageLeft;
         this.FUIPage1.ButtonNext.Substrate = FMC_Scene.MC_NineItems.MC_ChangePage.MC_PageRight;
         this.FUIPage1.LabelPage = FMC_Scene.MC_NineItems.MC_ChangePage.TF_Page;
         this.FUIPage1.TotalQuantity = this.FTotalPage1;
         this.FUIPage1.PageSize = BOX_COUNT_1;
         this.FUIPage1.PageIndex = 0;
         this.FCurPage1 = 0;
         this.FUIPage1.OnChangePage = this.ProcessorPageOnChange1;
         _loc2_ = 0;
         while(_loc2_ < TAB_COUNT)
         {
            this.FUITab.SetTabByIndex(FMC_Scene["MC_Tab" + _loc2_],_loc2_);
            _loc2_++;
         }
         this.FUITab.OnSwitch = this.ChangeTabOnSwitch;
         this.FUITab.Init();
         FMC_Scene.MC_Items.MC_ShowPet.MC_Hero.addChild(this.FLittlePetBmp);
         TGameUtil.setButtonMode(FMC_Scene.MC_Items.MC_ShowPet.BTN_ShowDesc,true);
         FMC_Scene.MC_Items.MC_ShowPet.BTN_ShowDesc.addEventListener(MouseEvent.CLICK,this.ProcessorOnShowHeroDesc);
         TGameUtil.setButtonMode(FMC_Scene.MC_Items.MC_ShowHero.BTN_ShowDesc,true);
         FMC_Scene.MC_Items.MC_ShowHero.BTN_ShowDesc.addEventListener(MouseEvent.CLICK,this.ProcessorOnShowHeroDesc);
      }
      
      protected function UpdateText() : void
      {
         var _loc1_:int = 0;
         var _loc2_:String = null;
         var _loc3_:int = 0;
         FMC_Scene.TF_Date.text = TUtilityString.Format(STRING_BASEACTIVITY.FormatString_ActivityTimeStartToEnd,TUtilityDate.FormatDateChineseNew(new Date(STimingCore.GetClientShowTime(this.FPersiaTrader.BeginTime) * 1000)),TUtilityDate.FormatDateChineseNew(new Date((STimingCore.GetClientShowTime(this.FPersiaTrader.EndTime) - 1) * 1000)));
         FMC_Scene.TF_Desc.text = this.FPersiaTrader.DescListNew[1];
      }
      
      protected function UpdateItem() : void
      {
         var _loc1_:int = 0;
         var _loc2_:int = 0;
         var _loc3_:int = 0;
         var _loc4_:int = 0;
         var _loc5_:int = 0;
         var _loc6_:String = null;
         var _loc7_:TBaseBoxes = null;
         var _loc8_:TBaseBox = null;
         if(this.FChangeTabIndex == 0 || this.FChangeTabIndex == 1)
         {
            FMC_Scene.MC_Items.visible = true;
            FMC_Scene.MC_NineItems.visible = false;
            this.FPetId = this.FPersiaTrader.PetID;
            this.FHeroId = this.FPersiaTrader.HeroID;
            if(this.FHeroActive == null)
            {
               this.FHeroActive = TPoolRole.GetActive(this,this.FHeroId,CONST_MODULES.ACTIVE_Test,false,false);
            }
            else
            {
               this.FHeroActive.ReloadRole();
            }
            if(FMC_Scene.MC_Items.MC_ShowHero.MC_Hero.numChildren > 0)
            {
               FMC_Scene.MC_Items.MC_ShowHero.MC_Hero.removeChildAt(0);
            }
            FMC_Scene.MC_Items.MC_ShowHero.MC_Hero.addChild(this.FHeroActive);
            if(this.FChangeTabIndex == 0)
            {
               FMC_Scene.MC_Items.MC_ShowHero.visible = true;
               FMC_Scene.MC_Items.MC_ShowPet.visible = false;
            }
            else if(this.FChangeTabIndex == 1)
            {
               FMC_Scene.MC_Items.MC_ShowHero.visible = false;
               FMC_Scene.MC_Items.MC_ShowPet.visible = true;
            }
            this.FUIPage.TotalQuantity = this.FPersiaTrader.ShowList[this.FChangeTabIndex].Items.length;
            this.FUIPage.Update();
            _loc1_ = 0;
            while(_loc1_ < BOX_COUNT)
            {
               _loc5_ = _loc1_ + this.FCurPage * BOX_COUNT;
               if(_loc5_ < this.FPersiaTrader.ShowList[this.FChangeTabIndex].Items.length)
               {
                  FMC_Scene.MC_Items["MC_Item" + _loc1_].visible = true;
                  _loc8_ = this.FPersiaTrader.ShowList[this.FChangeTabIndex].Items[_loc5_];
                  this.FShowList[_loc1_].UpdateUI(_loc8_.Inventories);
                  _loc6_ = _loc8_.Price + STRING_COMMON.ITEMNAME_Gold;
                  this.FShowList[_loc1_].SetDescText(0,_loc6_);
                  _loc6_ = _loc8_.Min + STRING_COMMON.ITEMNAME_Gold;
                  this.FShowList[_loc1_].SetDescText(1,_loc6_);
               }
               else
               {
                  FMC_Scene.MC_Items["MC_Item" + _loc1_].visible = false;
               }
               _loc1_++;
            }
         }
         else
         {
            FMC_Scene.MC_Items.visible = false;
            FMC_Scene.MC_NineItems.visible = true;
            this.FUIPage1.TotalQuantity = this.FPersiaTrader.ShowList[this.FChangeTabIndex].Items.length;
            this.FUIPage1.Update();
            _loc1_ = 0;
            while(_loc1_ < BOX_COUNT_1)
            {
               _loc5_ = _loc1_ + this.FCurPage1 * BOX_COUNT_1;
               if(_loc5_ < this.FPersiaTrader.ShowList[this.FChangeTabIndex].Items.length)
               {
                  FMC_Scene.MC_NineItems["MC_Item" + _loc1_].visible = true;
                  _loc8_ = this.FPersiaTrader.ShowList[this.FChangeTabIndex].Items[_loc5_];
                  this.FShowList1[_loc1_].UpdateUI(_loc8_.Inventories);
                  _loc6_ = _loc8_.Price + STRING_COMMON.ITEMNAME_Gold;
                  this.FShowList1[_loc1_].SetDescText(0,_loc6_);
                  _loc6_ = _loc8_.Min + STRING_COMMON.ITEMNAME_Gold;
                  this.FShowList1[_loc1_].SetDescText(1,_loc6_);
               }
               else
               {
                  FMC_Scene.MC_NineItems["MC_Item" + _loc1_].visible = false;
               }
               _loc1_++;
            }
         }
      }
      
      protected function ChangeTabOnSwitch(param1:Object) : void
      {
         var _loc2_:int = param1 as int;
         if(_loc2_ == this.FChangeTabIndex)
         {
            return;
         }
         this.FChangeTabIndex = _loc2_;
         this.FCurPage = 0;
         this.FUIPage.Reset();
         this.FCurPage1 = 0;
         this.FUIPage1.Reset();
         this.UpdateItem();
      }
      
      protected function ProcessorPageOnChange(param1:Object, param2:int) : void
      {
         this.FCurPage = param2;
         this.UpdateItem();
      }
      
      protected function ProcessorPageOnChange1(param1:Object, param2:int) : void
      {
         this.FCurPage1 = param2;
         this.UpdateItem();
      }
      
      protected function SlotsOnOver(param1:Object, param2:Object) : void
      {
         if(FOnItemOver != null)
         {
            FOnItemOver(this,param2);
         }
      }
      
      protected function SlotsOnOut(param1:Object, param2:Object) : void
      {
         if(FOnItemOut != null)
         {
            FOnItemOut(this,param2);
         }
      }
      
      protected function ProcessorOnShowRecruit(param1:uint, param2:int) : void
      {
         if(FOnShowRecruit != null)
         {
            FOnShowRecruit(param1,param2);
         }
      }
      
      protected function ProcessorOnShowHeroDesc(param1:MouseEvent) : void
      {
         if(FOnShowRecruit != null)
         {
            if(this.FChangeTabIndex == 0)
            {
               FOnShowRecruit(this.FHeroId,TBaseBox.TYPE_IS_HERO);
            }
            else if(this.FChangeTabIndex == 1)
            {
               FOnShowRecruit(this.FPetId,TBaseBox.TYPE_IS_PET);
            }
         }
      }
      
      override public function Perform_UIDispatch(param1:MovieClip) : void
      {
         super.Perform_UIDispatch(param1);
      }
      
      override public function LogicsPerform() : void
      {
         var _loc1_:int = 0;
         if(FInitialized && this.visible && FMC_Scene.visible)
         {
            _loc1_ = 0;
            while(_loc1_ < BOX_COUNT)
            {
               if(this.FShowList[_loc1_])
               {
                  this.FShowList[_loc1_].LogicsPerform();
               }
               _loc1_++;
            }
            _loc1_ = 0;
            while(_loc1_ < BOX_COUNT_1)
            {
               if(this.FShowList1[_loc1_])
               {
                  this.FShowList1[_loc1_].LogicsPerform();
               }
               _loc1_++;
            }
            if(this.FChangeTabIndex == 0)
            {
               if(this.FHeroId != 0)
               {
                  if(this.FHeroActive)
                  {
                     this.FHeroActive.UpdateActive();
                  }
               }
            }
            else if(this.FChangeTabIndex == 1)
            {
               if(this.FPetId != 0)
               {
                  TGameUtil.ShowImageByID(TGameUtil.Type_Pet,this.FLittlePetBmp,CONST_MODULES.ACTIVE_Test,this.FPetId,2);
               }
            }
            else
            {
               this.FLittlePetBmp.bitmapData = null;
            }
         }
      }
      
      override public function UpdateUI() : void
      {
         this.UpdateText();
         this.UpdateItem();
      }
      
      override public function PlayMovie(param1:int = 0, param2:Boolean = false) : void
      {
      }
      
      override public function MovieEnd() : void
      {
      }
      
      override public function Unmount() : void
      {
      }
      
      override public function SetMovieParam(param1:int = 0, param2:int = 0, param3:int = 0) : void
      {
      }
   }
}

