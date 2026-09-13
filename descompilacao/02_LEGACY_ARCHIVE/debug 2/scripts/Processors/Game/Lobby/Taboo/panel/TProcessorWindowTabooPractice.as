package Processors.Game.Lobby.Taboo.panel
{
   import Components.Pages.TUIPage;
   import Components.ScrollBar.TScrollBar;
   import Components.Standard.TUITab;
   import Foundation.Resources.SResourcesCore;
   import Foundation.UI.TUIComponent;
   import Foundation.Utilities.TGameUtil;
   import Foundation.Utilities.TUtilityString;
   import Logics.Characters.TCharacter;
   import Logics.Characters.THero;
   import Logics.Characters.THeros;
   import Logics.DatebaseVO.VO.TTabooAddition;
   import Logics.SLogicsCore;
   import Processors.Game.Lobby.Common.TProcessorLobbyWindow;
   import Processors.Game.Lobby.Taboo.Cell.Slot_taboo;
   import Processors.Game.Lobby.Taboo.Data.TabooData;
   import Processors.Game.Lobby.Taboo.Data.TabooDataCell;
   import Rendering.Overlayers.Taboo.TOverTabooStringTip;
   import Resources.Constants.CONST_COMMON;
   import Resources.Constants.CONST_DATEBASEVO;
   import Resources.Constants.CONST_MODULES;
   import Resources.Constants.CONST_TABOO;
   import Resources.Strings.STRING_COMMON;
   import Resources.Strings.STRING_TABOO;
   import Utilities.UI.Overlayers.TUtilityUIOverlayer;
   import flash.display.Bitmap;
   import flash.display.MovieClip;
   import flash.events.MouseEvent;
   import flash.text.TextField;
   
   public class TProcessorWindowTabooPractice extends TProcessorLobbyWindow
   {
      
      public static const C_TEN:int = 10;
      
      public static const C_Four:int = 4;
      
      public static const C_Five:int = 5;
      
      public static const C_Six:int = 6;
      
      public static const C_Seven:int = 7;
      
      public static const C_Eight:int = 8;
      
      public static const C_Nine:int = 9;
      
      public static const C_Ten:int = 10;
      
      protected static const QUALITYCOLOR_INDEX:Vector.<uint> = CONST_COMMON.QUALITYCOLOR_INDEX;
      
      protected var FThisPanel:MovieClip = null;
      
      protected var FDta:TabooData = null;
      
      protected var FCharacter:TCharacter;
      
      protected var FUIPage:TUIPage;
      
      protected var FHeroPageIndex:int;
      
      protected var FTabHeroIndex:int;
      
      protected var FUITabHeros:TUITab;
      
      protected var FCurHero:THero;
      
      protected var FCurTabIndex:int;
      
      protected var FTF_Life_Name:TextField;
      
      protected var FTF_Life_value:TextField;
      
      protected var FTF_Progress:TextField;
      
      protected var FMC_Btn_Inherit:MovieClip = null;
      
      protected var FBMD:Bitmap = null;
      
      protected var FUITab:TUITab;
      
      protected var FActive:Vector.<MovieClip> = null;
      
      protected var FSevenMovieClip:Vector.<MovieClip> = null;
      
      protected var FTExpDecTip:TOverTabooStringTip = null;
      
      protected var FVecSlot1:Vector.<Slot_taboo>;
      
      protected var FVecSlot2:Vector.<Slot_taboo>;
      
      protected var FVecSlot3:Vector.<Slot_taboo>;
      
      protected var FVecSlot4:Vector.<Slot_taboo>;
      
      protected var FVecSlot5:Vector.<Slot_taboo>;
      
      protected var FVecSlot6:Vector.<Slot_taboo>;
      
      protected var FVecSlot7:Vector.<Slot_taboo>;
      
      protected var FScrollBar:TScrollBar = null;
      
      protected var FMC_Price_Middle:MovieClip = null;
      
      protected var FSlotsOnMove:Function = null;
      
      protected var FSlotsOnOut:Function = null;
      
      protected var FSeeTaboo:Function;
      
      protected var FFunMove:Function;
      
      protected var FFunOut:Function;
      
      protected var FFunOver:Function;
      
      protected var FSevenFunOver:Function;
      
      protected var FSevenFunMove:Function;
      
      protected var FSevenFunOut:Function;
      
      protected var FInheritFun:Function;
      
      public function TProcessorWindowTabooPractice(param1:TUIComponent)
      {
         super(param1);
         this.FUIPage = new TUIPage(this);
         this.FUITabHeros = new TUITab(this);
         this.FUITab = new TUITab(this);
         this.FVecSlot1 = new Vector.<Slot_taboo>(C_Four);
         this.FVecSlot2 = new Vector.<Slot_taboo>(C_Five);
         this.FVecSlot3 = new Vector.<Slot_taboo>(C_Six);
         this.FVecSlot4 = new Vector.<Slot_taboo>(C_Seven);
         this.FVecSlot5 = new Vector.<Slot_taboo>(C_Eight);
         this.FVecSlot6 = new Vector.<Slot_taboo>(C_Nine);
         this.FVecSlot7 = new Vector.<Slot_taboo>(C_Ten);
         this.FActive = new Vector.<MovieClip>(C_Seven);
         this.FSevenMovieClip = new Vector.<MovieClip>(C_Seven);
      }
      
      public function set SlotsOnMove(param1:Function) : void
      {
         this.FSlotsOnMove = param1;
      }
      
      public function set SlotsOnOut(param1:Function) : void
      {
         this.FSlotsOnOut = param1;
      }
      
      protected function SlotsOnM(param1:Object, param2:Object) : void
      {
         this.FSlotsOnMove(param1,param2);
      }
      
      protected function SlotsOnO(param1:Object, param2:Object) : void
      {
         this.FSlotsOnOut(param1,param2);
      }
      
      public function SetPanel(param1:MovieClip) : void
      {
         this.FThisPanel = param1;
         this.FDta = SLogicsCore.TBooData;
         this.FCharacter = SLogicsCore.Character;
         this.FBMD = new Bitmap();
         this.initilization();
      }
      
      public function set SeeTaboo(param1:Function) : void
      {
         this.FSeeTaboo = param1;
      }
      
      protected function BackFun(param1:int) : void
      {
         if(this.FSeeTaboo != null)
         {
            this.FSeeTaboo(param1,this.FCurTabIndex + 1,this.FCurHero);
         }
      }
      
      public function set SevenFunOver(param1:Function) : void
      {
         this.FSevenFunOver = param1;
      }
      
      public function set SevenFunMove(param1:Function) : void
      {
         this.FSevenFunMove = param1;
      }
      
      public function set SevenFunOut(param1:Function) : void
      {
         this.FSevenFunOut = param1;
      }
      
      protected function SevenOver(param1:MouseEvent) : void
      {
         var _loc2_:String = param1.currentTarget.name;
         var _loc3_:int = int(_loc2_.charAt(_loc2_.length - 1));
         var _loc4_:Vector.<TabooDataCell> = null;
         _loc4_ = this.FDta.GetTabooDataCellVector(this.FCurHero,this.FCurTabIndex + 1,_loc3_);
         if(this.FSevenFunOver != null)
         {
            this.FSevenFunOver(this.FCurTabIndex + 1,_loc3_,this.FActive[_loc3_ - 1].visible,_loc4_.length);
         }
      }
      
      protected function SevenMove(param1:MouseEvent) : void
      {
         if(this.FSevenFunMove != null)
         {
            this.FSevenFunMove();
         }
      }
      
      protected function SevenOut(param1:MouseEvent) : void
      {
         if(this.FSevenFunOut != null)
         {
            this.FSevenFunOut();
         }
      }
      
      public function set FunOver(param1:Function) : void
      {
         this.FFunOver = param1;
      }
      
      public function set FunMove(param1:Function) : void
      {
         this.FFunMove = param1;
      }
      
      public function set FunOut(param1:Function) : void
      {
         this.FFunOut = param1;
      }
      
      protected function BackFunOver(param1:int) : void
      {
         if(this.FFunOver != null)
         {
            this.FFunOver(this.FCurTabIndex + 1,param1);
         }
      }
      
      protected function BackFunMove() : void
      {
         if(this.FFunMove != null)
         {
            this.FFunMove();
         }
      }
      
      protected function BackFunOut() : void
      {
         if(this.FFunOut != null)
         {
            this.FFunOut();
         }
      }
      
      protected function initilization() : void
      {
         var _loc1_:int = 0;
         var _loc2_:MovieClip = null;
         var _loc3_:Slot_taboo = null;
         this.FTF_Life_Name = this.FThisPanel["TF_Life_Name"];
         this.FTF_Life_value = this.FThisPanel["TF_Life_value"];
         this.FTF_Progress = this.FThisPanel["TF_Progress"];
         this.FMC_Btn_Inherit = this.FThisPanel["MC_Btn_Inherit"];
         TGameUtil.setButtonMode(this.FMC_Btn_Inherit,true);
         this.FMC_Btn_Inherit.addEventListener(MouseEvent.CLICK,this.HandleClick);
         this.FMC_Price_Middle = this.FThisPanel["MC_Price_Middle"];
         this.FScrollBar = new TScrollBar(this.FThisPanel["MC_List"],327,true,0,0,true);
         this.FScrollBar.Clear();
         this.FScrollBar.AddItem(this.FMC_Price_Middle);
         this.FScrollBar.ScrollToUp();
         _loc1_ = 0;
         while(_loc1_ < C_TEN)
         {
            _loc2_ = this.FThisPanel["TF_HeroName_" + _loc1_];
            this.FUITabHeros.SetTabByIndex(_loc2_,_loc1_);
            this.FUITabHeros.SetTabCaptionByIndex("",_loc1_);
            _loc1_++;
         }
         this.FUITabHeros.OnSwitch = this.TabHerosOnSwitch;
         this.FUITabHeros.Init();
         _loc1_ = 0;
         while(_loc1_ < C_Seven)
         {
            TextField(this.FThisPanel["MC_Price_Middle"]["TF_FightingCapacity" + _loc1_]).mouseEnabled = false;
            this.FActive[_loc1_] = this.FThisPanel["MC_Price_Middle"]["MC_Activationed" + _loc1_];
            this.FActive[_loc1_].mouseEnabled = false;
            this.FSevenMovieClip[_loc1_] = this.FThisPanel["MC_Price_Middle"]["MC_JIE_" + (_loc1_ + 1)];
            this.FSevenMovieClip[_loc1_].addEventListener(MouseEvent.MOUSE_OVER,this.SevenOver);
            this.FSevenMovieClip[_loc1_].addEventListener(MouseEvent.MOUSE_MOVE,this.SevenMove);
            this.FSevenMovieClip[_loc1_].addEventListener(MouseEvent.MOUSE_OUT,this.SevenOut);
            _loc1_++;
         }
         _loc1_ = 0;
         while(_loc1_ < C_Four)
         {
            _loc3_ = new Slot_taboo();
            _loc3_.SetPanel(this.FThisPanel["MC_Price_Middle"]["MC_Slot_1" + _loc1_],1);
            _loc3_.IsAddEventListener();
            _loc3_.BackFun = this.BackFun;
            _loc3_.SlotsOnM = this.SlotsOnM;
            _loc3_.SlotsOnO = this.SlotsOnO;
            _loc3_.BackFunMove = this.BackFunMove;
            _loc3_.BackFunOver = this.BackFunOver;
            _loc3_.BackFunOut = this.BackFunOut;
            this.FVecSlot1[_loc1_] = _loc3_;
            _loc1_++;
         }
         _loc1_ = 0;
         while(_loc1_ < C_Five)
         {
            _loc3_ = new Slot_taboo();
            _loc3_.SetPanel(this.FThisPanel["MC_Price_Middle"]["MC_Slot_2" + _loc1_],2);
            _loc3_.IsAddEventListener();
            _loc3_.BackFun = this.BackFun;
            _loc3_.SlotsOnM = this.SlotsOnM;
            _loc3_.SlotsOnO = this.SlotsOnO;
            _loc3_.BackFunMove = this.BackFunMove;
            _loc3_.BackFunOver = this.BackFunOver;
            _loc3_.BackFunOut = this.BackFunOut;
            this.FVecSlot2[_loc1_] = _loc3_;
            _loc1_++;
         }
         _loc1_ = 0;
         while(_loc1_ < C_Six)
         {
            _loc3_ = new Slot_taboo();
            _loc3_.SetPanel(this.FThisPanel["MC_Price_Middle"]["MC_Slot_3" + _loc1_],3);
            _loc3_.IsAddEventListener();
            _loc3_.BackFun = this.BackFun;
            _loc3_.SlotsOnM = this.SlotsOnM;
            _loc3_.SlotsOnO = this.SlotsOnO;
            _loc3_.BackFunMove = this.BackFunMove;
            _loc3_.BackFunOver = this.BackFunOver;
            _loc3_.BackFunOut = this.BackFunOut;
            this.FVecSlot3[_loc1_] = _loc3_;
            _loc1_++;
         }
         _loc1_ = 0;
         while(_loc1_ < C_Seven)
         {
            _loc3_ = new Slot_taboo();
            _loc3_.SetPanel(this.FThisPanel["MC_Price_Middle"]["MC_Slot_4" + _loc1_],4);
            _loc3_.IsAddEventListener();
            _loc3_.BackFun = this.BackFun;
            _loc3_.SlotsOnM = this.SlotsOnM;
            _loc3_.SlotsOnO = this.SlotsOnO;
            _loc3_.BackFunMove = this.BackFunMove;
            _loc3_.BackFunOver = this.BackFunOver;
            _loc3_.BackFunOut = this.BackFunOut;
            this.FVecSlot4[_loc1_] = _loc3_;
            _loc1_++;
         }
         _loc1_ = 0;
         while(_loc1_ < C_Eight)
         {
            _loc3_ = new Slot_taboo();
            _loc3_.SetPanel(this.FThisPanel["MC_Price_Middle"]["MC_Slot_5" + _loc1_],5);
            _loc3_.IsAddEventListener();
            _loc3_.BackFun = this.BackFun;
            _loc3_.SlotsOnM = this.SlotsOnM;
            _loc3_.SlotsOnO = this.SlotsOnO;
            _loc3_.BackFunMove = this.BackFunMove;
            _loc3_.BackFunOver = this.BackFunOver;
            _loc3_.BackFunOut = this.BackFunOut;
            this.FVecSlot5[_loc1_] = _loc3_;
            _loc1_++;
         }
         _loc1_ = 0;
         while(_loc1_ < C_Nine)
         {
            _loc3_ = new Slot_taboo();
            _loc3_.SetPanel(this.FThisPanel["MC_Price_Middle"]["MC_Slot_6" + _loc1_],6);
            _loc3_.IsAddEventListener();
            _loc3_.BackFun = this.BackFun;
            _loc3_.SlotsOnM = this.SlotsOnM;
            _loc3_.SlotsOnO = this.SlotsOnO;
            _loc3_.BackFunMove = this.BackFunMove;
            _loc3_.BackFunOver = this.BackFunOver;
            _loc3_.BackFunOut = this.BackFunOut;
            this.FVecSlot6[_loc1_] = _loc3_;
            _loc1_++;
         }
         _loc1_ = 0;
         while(_loc1_ < C_Ten)
         {
            _loc3_ = new Slot_taboo();
            _loc3_.SetPanel(this.FThisPanel["MC_Price_Middle"]["MC_Slot_7" + _loc1_],7);
            _loc3_.IsAddEventListener();
            _loc3_.BackFun = this.BackFun;
            _loc3_.SlotsOnM = this.SlotsOnM;
            _loc3_.SlotsOnO = this.SlotsOnO;
            _loc3_.BackFunMove = this.BackFunMove;
            _loc3_.BackFunOver = this.BackFunOver;
            _loc3_.BackFunOut = this.BackFunOut;
            this.FVecSlot7[_loc1_] = _loc3_;
            _loc1_++;
         }
         this.FUIPage.ButtonPrevious.Substrate = this.FThisPanel["MC_HeroPage"]["MC_PageLeft"];
         this.FUIPage.ButtonNext.Substrate = this.FThisPanel["MC_HeroPage"]["MC_PageRight"];
         this.FUIPage.LabelPage = this.FThisPanel["MC_HeroPage"]["TF_Page"];
         TextField(this.FThisPanel["MC_HeroPage"]["TF_Page"]).text = "0/0";
         this.FUIPage.PageSize = C_TEN;
         this.FUIPage.Init();
         this.FUIPage.OnChangePage = this.HeroPageOnChange;
         this.FUITab.SetTabByIndex(this.FThisPanel["MC_Equipment"],0);
         this.FUITab.SetTabByIndex(this.FThisPanel["MC_Appliance"],1);
         this.FUITab.SetTabByIndex(this.FThisPanel["MC_Arage"],2);
         this.FUITab.SetTabByIndex(this.FThisPanel["MC_Idea"],3);
         this.FUITab.SetTabByIndex(this.FThisPanel["MC_Barrier"],4);
         this.FUITab.SetTabByIndex(this.FThisPanel["MC_Scherm"],5);
         this.FUITab.OnSwitch = this.TabOnSwitch;
         this.FUITab.Init();
         this.FUITab.SetTabHideByIndexCopy(3);
         MovieClip(this.FThisPanel["MC_HeroImage"]["MC_Slot_Pic"]["IconMountPoint"]).addChild(this.FBMD);
         this.FTExpDecTip = new TOverTabooStringTip(this.Parent.Parent);
         this.FTExpDecTip.visible = false;
         TUtilityUIOverlayer.ResourcesDispatch(this.FTExpDecTip);
      }
      
      public function SetVisibel(param1:Boolean) : void
      {
         var _loc2_:int = 0;
         _loc2_ = 0;
         while(_loc2_ < 6)
         {
            MovieClip(this.FUITab.GetMoviClipByIndex(_loc2_)["MC_Num"]).visible = param1;
            _loc2_++;
         }
      }
      
      protected function TabOnSwitch(param1:Object) : void
      {
         this.FCurTabIndex = param1 as int;
         this.UpdateSevenCy();
      }
      
      public function UPudatePrice() : void
      {
         this.UpdateSevenCy();
      }
      
      protected function TabHerosOnSwitch(param1:Object) : void
      {
         this.FTabHeroIndex = param1 as int;
         this.FTabHeroIndex += this.FHeroPageIndex * C_TEN;
         this.FCurHero = this.FCharacter.Heros.GetHeroByIndex(this.FTabHeroIndex);
         this.FUITab.SwithTagManual(0);
         this.UpdateSevenCy();
      }
      
      protected function HeroPageOnChange(param1:Object, param2:int) : void
      {
         this.FHeroPageIndex = param2;
         this.FTabHeroIndex = 0;
         this.FTabHeroIndex = this.FHeroPageIndex * C_TEN;
         this.FCurHero = this.FCharacter.Heros.GetHeroByIndex(this.FTabHeroIndex);
         this.UpdateTabs();
         this.TabHerosOnSwitch(this);
         this.UpdateSevenCy();
      }
      
      public function OpenThisPanel() : void
      {
         this.FHeroPageIndex = 0;
         this.FTabHeroIndex = 0;
         this.FCurHero = this.FCharacter.Heros.GetHeroByIndex(this.FTabHeroIndex);
         this.UpdateTabs();
         this.FUITabHeros.SwithTagManual(0);
         this.UpdateHeroUIPage();
         this.UpdateSevenCy();
      }
      
      protected function UpdateTabs() : void
      {
         var _loc1_:int = 0;
         var _loc2_:int = 0;
         var _loc3_:THeros = null;
         var _loc4_:THero = null;
         var _loc5_:uint = 0;
         var _loc6_:uint = 0;
         _loc3_ = this.FCharacter.Heros;
         _loc3_.Sort();
         _loc2_ = _loc3_.Count;
         _loc1_ = 0;
         while(_loc1_ < C_TEN)
         {
            _loc6_ = _loc1_ + this.FHeroPageIndex * C_TEN;
            if(_loc6_ >= _loc2_)
            {
               this.FUITabHeros.SetTabHideByIndex(_loc1_);
            }
            else
            {
               _loc4_ = _loc3_.GetHeroByIndex(_loc6_);
               _loc5_ = QUALITYCOLOR_INDEX[_loc4_.Quality];
               this.FUITabHeros.SetTabCaptionByIndex(_loc4_.Name,_loc1_,_loc5_);
               this.FUITabHeros.SetTabShowByIndex(_loc1_);
            }
            _loc1_++;
         }
      }
      
      public function UpdateHeroUIPage() : void
      {
         this.FUIPage.TotalQuantity = this.FCharacter.Heros.Count;
         this.FUIPage.PageIndex = this.FHeroPageIndex;
         this.FUIPage.Update();
      }
      
      public function UpdateSevenOnleOne(param1:int) : void
      {
         var _loc3_:int = 0;
         var _loc4_:int = 0;
         var _loc5_:int = 0;
         var _loc2_:Vector.<TabooDataCell> = null;
         if(param1 == 1)
         {
            _loc2_ = this.FDta.GetTabooDataCellVector(this.FCurHero,this.FCurTabIndex + 1,1);
            this.FActive[0].visible = true;
            _loc3_ = 0;
            while(_loc3_ < C_Four)
            {
               if(_loc3_ < _loc2_.length)
               {
                  this.FVecSlot1[_loc3_].SetData(_loc2_[_loc3_]);
               }
               else
               {
                  this.FVecSlot1[_loc3_].SetData(null);
                  this.FActive[0].visible = false;
                  if(!_loc5_ && this.FDta.GetBooleanToBagById(this.FCurTabIndex + 1,1))
                  {
                     this.FVecSlot1[_loc3_].MiddleBtnVisibel = true;
                  }
                  _loc5_++;
               }
               _loc3_++;
            }
         }
         else if(param1 == 2)
         {
            _loc2_ = this.FDta.GetTabooDataCellVector(this.FCurHero,this.FCurTabIndex + 1,2);
            this.FActive[1].visible = true;
            _loc3_ = 0;
            while(_loc3_ < C_Five)
            {
               if(_loc3_ < _loc2_.length)
               {
                  this.FVecSlot2[_loc3_].SetData(_loc2_[_loc3_]);
               }
               else
               {
                  this.FVecSlot2[_loc3_].SetData(null);
                  this.FActive[1].visible = false;
                  if(!_loc5_ && this.FDta.GetBooleanToBagById(this.FCurTabIndex + 1,2))
                  {
                     this.FVecSlot2[_loc3_].MiddleBtnVisibel = true;
                  }
                  _loc5_++;
               }
               _loc3_++;
            }
         }
         else if(param1 == 3)
         {
            _loc2_ = this.FDta.GetTabooDataCellVector(this.FCurHero,this.FCurTabIndex + 1,3);
            this.FActive[2].visible = true;
            _loc3_ = 0;
            while(_loc3_ < C_Six)
            {
               if(_loc3_ < _loc2_.length)
               {
                  this.FVecSlot3[_loc3_].SetData(_loc2_[_loc3_]);
               }
               else
               {
                  this.FVecSlot3[_loc3_].SetData(null);
                  this.FActive[2].visible = false;
                  if(!_loc5_ && this.FDta.GetBooleanToBagById(this.FCurTabIndex + 1,3))
                  {
                     this.FVecSlot3[_loc3_].MiddleBtnVisibel = true;
                  }
                  _loc5_++;
               }
               _loc3_++;
            }
         }
         else if(param1 == 4)
         {
            _loc2_ = this.FDta.GetTabooDataCellVector(this.FCurHero,this.FCurTabIndex + 1,4);
            this.FActive[3].visible = true;
            _loc3_ = 0;
            while(_loc3_ < C_Seven)
            {
               if(_loc3_ < _loc2_.length)
               {
                  this.FVecSlot4[_loc3_].SetData(_loc2_[_loc3_]);
               }
               else
               {
                  this.FVecSlot4[_loc3_].SetData(null);
                  this.FActive[3].visible = false;
                  if(!_loc5_ && this.FDta.GetBooleanToBagById(this.FCurTabIndex + 1,4))
                  {
                     this.FVecSlot4[_loc3_].MiddleBtnVisibel = true;
                  }
                  _loc5_++;
               }
               _loc3_++;
            }
         }
         else if(param1 == 5)
         {
            _loc2_ = this.FDta.GetTabooDataCellVector(this.FCurHero,this.FCurTabIndex + 1,5);
            this.FActive[4].visible = true;
            _loc3_ = 0;
            while(_loc3_ < C_Eight)
            {
               if(_loc3_ < _loc2_.length)
               {
                  this.FVecSlot5[_loc3_].SetData(_loc2_[_loc3_]);
               }
               else
               {
                  this.FVecSlot5[_loc3_].SetData(null);
                  this.FActive[4].visible = false;
                  if(!_loc5_ && this.FDta.GetBooleanToBagById(this.FCurTabIndex + 1,5))
                  {
                     this.FVecSlot5[_loc3_].MiddleBtnVisibel = true;
                  }
                  _loc5_++;
               }
               _loc3_++;
            }
         }
         else if(param1 == 6)
         {
            _loc2_ = this.FDta.GetTabooDataCellVector(this.FCurHero,this.FCurTabIndex + 1,6);
            this.FActive[5].visible = true;
            _loc3_ = 0;
            while(_loc3_ < C_Nine)
            {
               if(_loc3_ < _loc2_.length)
               {
                  this.FVecSlot6[_loc3_].SetData(_loc2_[_loc3_]);
               }
               else
               {
                  this.FVecSlot6[_loc3_].SetData(null);
                  this.FActive[5].visible = false;
                  if(!_loc5_ && this.FDta.GetBooleanToBagById(this.FCurTabIndex + 1,6))
                  {
                     this.FVecSlot6[_loc3_].MiddleBtnVisibel = true;
                  }
                  _loc5_++;
               }
               _loc3_++;
            }
         }
         else
         {
            _loc2_ = this.FDta.GetTabooDataCellVector(this.FCurHero,this.FCurTabIndex + 1,7);
            this.FActive[6].visible = true;
            _loc3_ = 0;
            while(_loc3_ < C_Ten)
            {
               if(_loc3_ < _loc2_.length)
               {
                  this.FVecSlot7[_loc3_].SetData(_loc2_[_loc3_]);
               }
               else
               {
                  this.FVecSlot7[_loc3_].SetData(null);
                  this.FActive[6].visible = false;
                  if(!_loc5_ && this.FDta.GetBooleanToBagById(this.FCurTabIndex + 1,7))
                  {
                     this.FVecSlot7[_loc3_].MiddleBtnVisibel = true;
                  }
                  _loc5_++;
               }
               _loc3_++;
            }
         }
         this.Settext(this.FCurTabIndex + 1);
      }
      
      public function Settext(param1:int) : void
      {
         var _loc2_:uint = 0;
         var _loc3_:TTabooAddition = null;
         _loc2_ = CONST_TABOO.Configuration_Base + param1 * 1000 + 1 + 0;
         _loc3_ = SResourcesCore.ResourceBin.GetDatebase(CONST_DATEBASEVO.RESOURCEID_TabooAddition,_loc2_) as TTabooAddition;
         var _loc4_:String = STRING_COMMON.STRINGS_BASEATTRIBUTENAMES[CONST_COMMON.BASEATTRIBUTENAMES.indexOf(_loc3_.AddProperty[0][0])];
         if(_loc3_.AddProperty.length > 1)
         {
            _loc4_ = STRING_TABOO.Str23;
         }
         this.FTF_Life_Name.text = _loc4_;
         this.FTF_Life_value.text = this.GetCurAllValue(param1).toString();
         var _loc5_:Number = Number(this.GetCurAllValue(param1) / this.FDta.GetAllValueByType(param1)) * 100;
         if(_loc5_ == 100)
         {
            this.FTF_Progress.text = TUtilityString.Format(STRING_TABOO.Str27,100);
         }
         else if(_loc5_ == 0)
         {
            this.FTF_Progress.text = TUtilityString.Format(STRING_TABOO.Str27,0);
         }
         else
         {
            this.FTF_Progress.text = TUtilityString.Format(STRING_TABOO.Str27,_loc5_.toFixed(2));
         }
         TextField(this.FThisPanel["MC_HeroImage"]["MC_Slot_Pic"]["HeroName"]).text = this.FCurHero.Name;
         TextField(this.FThisPanel["MC_HeroImage"]["MC_Slot_Pic"]["HeroName"]).textColor = QUALITYCOLOR_INDEX[this.FCurHero.Quality];
      }
      
      protected function GetCurAllValue(param1:int) : uint
      {
         var _loc3_:int = 0;
         var _loc4_:int = 0;
         var _loc5_:uint = 0;
         var _loc6_:TTabooAddition = null;
         var _loc2_:Vector.<TabooDataCell> = null;
         _loc2_ = this.FDta.GetTabooDataCellVector(this.FCurHero,param1,1);
         _loc3_ = 0;
         while(_loc3_ < _loc2_.length)
         {
            _loc5_ += _loc2_[_loc3_].ConfigureAddition.AddProperty[0][1];
            _loc3_++;
         }
         if(_loc2_.length >= C_Four)
         {
            _loc5_ += _loc2_[C_Four - 1].ConfigureAddition.AddEffectArr[0][1];
         }
         _loc2_ = this.FDta.GetTabooDataCellVector(this.FCurHero,param1,2);
         _loc3_ = 0;
         while(_loc3_ < _loc2_.length)
         {
            _loc5_ += _loc2_[_loc3_].ConfigureAddition.AddProperty[0][1];
            _loc3_++;
         }
         if(_loc2_.length >= C_Five)
         {
            _loc5_ += _loc2_[C_Five - 1].ConfigureAddition.AddEffectArr[0][1];
         }
         _loc2_ = this.FDta.GetTabooDataCellVector(this.FCurHero,param1,3);
         _loc3_ = 0;
         while(_loc3_ < _loc2_.length)
         {
            _loc5_ += _loc2_[_loc3_].ConfigureAddition.AddProperty[0][1];
            _loc3_++;
         }
         if(_loc2_.length >= C_Six)
         {
            _loc5_ += _loc2_[C_Six - 1].ConfigureAddition.AddEffectArr[0][1];
         }
         _loc2_ = this.FDta.GetTabooDataCellVector(this.FCurHero,param1,4);
         _loc3_ = 0;
         while(_loc3_ < _loc2_.length)
         {
            _loc5_ += _loc2_[_loc3_].ConfigureAddition.AddProperty[0][1];
            _loc3_++;
         }
         if(_loc2_.length >= C_Seven)
         {
            _loc5_ += _loc2_[C_Seven - 1].ConfigureAddition.AddEffectArr[0][1];
         }
         _loc2_ = this.FDta.GetTabooDataCellVector(this.FCurHero,param1,5);
         _loc3_ = 0;
         while(_loc3_ < _loc2_.length)
         {
            _loc5_ += _loc2_[_loc3_].ConfigureAddition.AddProperty[0][1];
            _loc3_++;
         }
         if(_loc2_.length >= C_Eight)
         {
            _loc5_ += _loc2_[C_Eight - 1].ConfigureAddition.AddEffectArr[0][1];
         }
         _loc2_ = this.FDta.GetTabooDataCellVector(this.FCurHero,param1,6);
         _loc3_ = 0;
         while(_loc3_ < _loc2_.length)
         {
            _loc5_ += _loc2_[_loc3_].ConfigureAddition.AddProperty[0][1];
            _loc3_++;
         }
         if(_loc2_.length >= C_Nine)
         {
            _loc5_ += _loc2_[C_Nine - 1].ConfigureAddition.AddEffectArr[0][1];
         }
         _loc2_ = this.FDta.GetTabooDataCellVector(this.FCurHero,param1,7);
         _loc3_ = 0;
         while(_loc3_ < _loc2_.length)
         {
            _loc5_ += _loc2_[_loc3_].ConfigureAddition.AddProperty[0][1];
            _loc3_++;
         }
         if(_loc2_.length >= C_Ten)
         {
            _loc5_ += _loc2_[C_Ten - 1].ConfigureAddition.AddEffectArr[0][1];
         }
         return _loc5_;
      }
      
      protected function UpdateSevenCy() : void
      {
         var _loc2_:int = 0;
         var _loc3_:int = 0;
         var _loc4_:int = 0;
         var _loc1_:Vector.<TabooDataCell> = null;
         _loc2_ = 0;
         while(_loc2_ < C_Seven)
         {
            this.FActive[_loc2_].visible = true;
            _loc2_++;
         }
         _loc1_ = this.FDta.GetTabooDataCellVector(this.FCurHero,this.FCurTabIndex + 1,1);
         _loc2_ = 0;
         while(_loc2_ < C_Four)
         {
            if(_loc2_ < _loc1_.length)
            {
               this.FVecSlot1[_loc2_].SetData(_loc1_[_loc2_]);
            }
            else
            {
               this.FVecSlot1[_loc2_].SetData(null);
               this.FActive[0].visible = false;
               if(!_loc4_ && this.FDta.GetBooleanToBagById(this.FCurTabIndex + 1,1))
               {
                  this.FVecSlot1[_loc2_].MiddleBtnVisibel = true;
               }
               _loc4_++;
            }
            _loc2_++;
         }
         _loc1_ = this.FDta.GetTabooDataCellVector(this.FCurHero,this.FCurTabIndex + 1,2);
         _loc4_ = 0;
         _loc2_ = 0;
         while(_loc2_ < C_Five)
         {
            if(_loc2_ < _loc1_.length)
            {
               this.FVecSlot2[_loc2_].SetData(_loc1_[_loc2_]);
            }
            else
            {
               this.FVecSlot2[_loc2_].SetData(null);
               this.FActive[1].visible = false;
               if(!_loc4_ && this.FDta.GetBooleanToBagById(this.FCurTabIndex + 1,2))
               {
                  this.FVecSlot2[_loc2_].MiddleBtnVisibel = true;
               }
               _loc4_++;
            }
            _loc2_++;
         }
         _loc1_ = this.FDta.GetTabooDataCellVector(this.FCurHero,this.FCurTabIndex + 1,3);
         _loc4_ = 0;
         _loc2_ = 0;
         while(_loc2_ < C_Six)
         {
            if(_loc2_ < _loc1_.length)
            {
               this.FVecSlot3[_loc2_].SetData(_loc1_[_loc2_]);
            }
            else
            {
               this.FVecSlot3[_loc2_].SetData(null);
               this.FActive[2].visible = false;
               if(!_loc4_ && this.FDta.GetBooleanToBagById(this.FCurTabIndex + 1,3))
               {
                  this.FVecSlot3[_loc2_].MiddleBtnVisibel = true;
               }
               _loc4_++;
            }
            _loc2_++;
         }
         _loc1_ = this.FDta.GetTabooDataCellVector(this.FCurHero,this.FCurTabIndex + 1,4);
         _loc4_ = 0;
         _loc2_ = 0;
         while(_loc2_ < C_Seven)
         {
            if(_loc2_ < _loc1_.length)
            {
               this.FVecSlot4[_loc2_].SetData(_loc1_[_loc2_]);
            }
            else
            {
               this.FVecSlot4[_loc2_].SetData(null);
               this.FActive[3].visible = false;
               if(!_loc4_ && this.FDta.GetBooleanToBagById(this.FCurTabIndex + 1,4))
               {
                  this.FVecSlot4[_loc2_].MiddleBtnVisibel = true;
               }
               _loc4_++;
            }
            _loc2_++;
         }
         _loc1_ = this.FDta.GetTabooDataCellVector(this.FCurHero,this.FCurTabIndex + 1,5);
         _loc4_ = 0;
         _loc2_ = 0;
         while(_loc2_ < C_Eight)
         {
            if(_loc2_ < _loc1_.length)
            {
               this.FVecSlot5[_loc2_].SetData(_loc1_[_loc2_]);
            }
            else
            {
               this.FVecSlot5[_loc2_].SetData(null);
               this.FActive[4].visible = false;
               if(!_loc4_ && this.FDta.GetBooleanToBagById(this.FCurTabIndex + 1,5))
               {
                  this.FVecSlot5[_loc2_].MiddleBtnVisibel = true;
               }
               _loc4_++;
            }
            _loc2_++;
         }
         _loc1_ = this.FDta.GetTabooDataCellVector(this.FCurHero,this.FCurTabIndex + 1,6);
         _loc4_ = 0;
         _loc2_ = 0;
         while(_loc2_ < C_Nine)
         {
            if(_loc2_ < _loc1_.length)
            {
               this.FVecSlot6[_loc2_].SetData(_loc1_[_loc2_]);
            }
            else
            {
               this.FVecSlot6[_loc2_].SetData(null);
               this.FActive[5].visible = false;
               if(!_loc4_ && this.FDta.GetBooleanToBagById(this.FCurTabIndex + 1,6))
               {
                  this.FVecSlot6[_loc2_].MiddleBtnVisibel = true;
               }
               _loc4_++;
            }
            _loc2_++;
         }
         _loc1_ = this.FDta.GetTabooDataCellVector(this.FCurHero,this.FCurTabIndex + 1,7);
         _loc4_ = 0;
         _loc2_ = 0;
         while(_loc2_ < C_Ten)
         {
            if(_loc2_ < _loc1_.length)
            {
               this.FVecSlot7[_loc2_].SetData(_loc1_[_loc2_]);
            }
            else
            {
               this.FVecSlot7[_loc2_].SetData(null);
               this.FActive[6].visible = false;
               if(!_loc4_ && this.FDta.GetBooleanToBagById(this.FCurTabIndex + 1,7))
               {
                  this.FVecSlot7[_loc2_].MiddleBtnVisibel = true;
               }
               _loc4_++;
            }
            _loc2_++;
         }
         this.Settext(this.FCurTabIndex + 1);
      }
      
      public function UpdateEnterFream() : void
      {
         var _loc1_:int = 0;
         if(!this.FThisPanel)
         {
            return;
         }
         if(!this.FThisPanel.visible)
         {
            return;
         }
         _loc1_ = 0;
         while(_loc1_ < C_Four)
         {
            this.FVecSlot1[_loc1_].UpdateImage();
            _loc1_++;
         }
         _loc1_ = 0;
         while(_loc1_ < C_Five)
         {
            this.FVecSlot2[_loc1_].UpdateImage();
            _loc1_++;
         }
         _loc1_ = 0;
         while(_loc1_ < C_Six)
         {
            this.FVecSlot3[_loc1_].UpdateImage();
            _loc1_++;
         }
         _loc1_ = 0;
         while(_loc1_ < C_Seven)
         {
            this.FVecSlot4[_loc1_].UpdateImage();
            _loc1_++;
         }
         _loc1_ = 0;
         while(_loc1_ < C_Eight)
         {
            this.FVecSlot5[_loc1_].UpdateImage();
            _loc1_++;
         }
         _loc1_ = 0;
         while(_loc1_ < C_Nine)
         {
            this.FVecSlot6[_loc1_].UpdateImage();
            _loc1_++;
         }
         _loc1_ = 0;
         while(_loc1_ < C_Ten)
         {
            this.FVecSlot7[_loc1_].UpdateImage();
            _loc1_++;
         }
         this.UpdateImage();
      }
      
      protected function HandleClick(param1:MouseEvent) : void
      {
         if(this.FInheritFun != null)
         {
            this.FInheritFun();
         }
      }
      
      public function set InheritFun(param1:Function) : void
      {
         this.FInheritFun = param1;
      }
      
      public function get ThisPanel() : MovieClip
      {
         return this.FThisPanel;
      }
      
      protected function OnMove(param1:TUITab, param2:int, param3:Boolean) : void
      {
         if(this.FTExpDecTip != null)
         {
            this.FTExpDecTip.Render(FUICore.MouseCoordinate);
         }
      }
      
      protected function OnOver(param1:TUITab, param2:int, param3:Boolean) : void
      {
         param2 += this.FHeroPageIndex * C_TEN;
         if(this.FTExpDecTip != null)
         {
            this.FTExpDecTip.Context = this.GetStr(this.FCharacter.Heros.GetHeroByIndex(param2));
            this.FTExpDecTip.Render(FUICore.MouseCoordinate);
            this.FTExpDecTip.Show();
         }
      }
      
      protected function GetStr(param1:THero) : String
      {
         var _loc2_:String = "";
         if(param1.IsSkillInherit && param1.IsSkillInherited)
         {
            _loc2_ = STRING_TABOO.Str4;
         }
         else if(param1.IsSkillInherit)
         {
            _loc2_ = STRING_TABOO.Str21;
         }
         else if(param1.IsSkillInherited)
         {
            _loc2_ = STRING_TABOO.Str22;
         }
         else
         {
            _loc2_ = STRING_TABOO.Str1;
         }
         return _loc2_;
      }
      
      protected function OnOut(param1:TUITab, param2:int, param3:Boolean) : void
      {
         if(this.FTExpDecTip != null)
         {
            this.FTExpDecTip.Hide();
         }
      }
      
      protected function UpdateImage() : void
      {
         if(!this.FCurHero)
         {
            return;
         }
         TGameUtil.ShowImageByID(TGameUtil.Type_HeadIcon,this.FBMD,CONST_MODULES.MODULE_Taboo,this.FCurHero.SmallID);
      }
   }
}

