package Processors.Game.Lobby.MasterRoad
{
   import Components.Pages.TUIPage;
   import Foundation.Common.THint;
   import Foundation.Network.TPacket;
   import Foundation.Resources.SResourcesCore;
   import Foundation.Timing.STimingCore;
   import Foundation.UI.TUIComponent;
   import Foundation.Utilities.TGameUtil;
   import Foundation.Utilities.TUtilityDate;
   import Foundation.Utilities.TUtilityString;
   import Logics.DatebaseVO.VO.TSystemLanguage;
   import Logics.Exercise.ConsumeRank.TConsumeRankInfo;
   import Logics.MasterRoad.TMasterRoad;
   import Logics.SLogicsCore;
   import Processors.Game.Lobby.Exercise.BaseActivity.Compoents.TUIBaseWindow;
   import Processors.Game.Lobby.TreasureMap.ConsumeFrameCopy;
   import Rendering.Overlayers.MasterRoad.TOverlayerHonorPlayer;
   import Resources.Constants.CONST_COMMON;
   import Resources.Constants.CONST_DATEBASEVO;
   import Resources.Constants.CONST_MODULES;
   import Resources.Constants.CONST_SYSTEMLANGUAGE;
   import Resources.Strings.STRING_MASTERROAD;
   import Utilities.UI.Overlayers.TUtilityUIOverlayer;
   import flash.display.Bitmap;
   import flash.display.MovieClip;
   import flash.events.MouseEvent;
   import flash.text.TextField;
   import flash.utils.ByteArray;
   
   public class TUIMasterRoadTemple extends TUIBaseWindow
   {
      
      public static const TAB_COUNT:int = 60;
      
      public static const BEFORE_COUNT:int = 28;
      
      protected var FMasterRoad:TMasterRoad;
      
      protected var FUIPage:TUIPage;
      
      protected var FTotalPage:int;
      
      protected var FCurPage:int;
      
      protected var FHeadBitmap:Bitmap;
      
      protected var FTF_Manifesto:TextField;
      
      protected var FOverlayerHonorPlayer:TOverlayerHonorPlayer;
      
      protected var FHelpTips:THint;
      
      protected var FHeadbitmapVect:Vector.<Bitmap>;
      
      public function TUIMasterRoadTemple(param1:TUIComponent)
      {
         super(param1);
         this.FMasterRoad = SLogicsCore.MasterRoad;
         this.FUIPage = new TUIPage(this);
         this.FHelpTips = new THint();
      }
      
      override protected function Resources_UIDispatch(param1:MovieClip) : void
      {
         var _loc2_:int = 0;
         var _loc3_:int = 0;
         var _loc4_:MovieClip = null;
         super.Resources_UIDispatch(param1);
         this.graphics.beginFill(0,0.6);
         this.graphics.drawRect(0,0,CONST_COMMON.STAGE_Width,CONST_COMMON.STAGE_Height);
         this.graphics.endFill();
         FMC_Scene = param1;
         addChild(FMC_Scene);
         FMC_Scene.x = (FUICore.StageWidth - FMC_Scene.width) / 2;
         FMC_Scene.y = (FUICore.StageHeight - FMC_Scene.height) / 2;
         FMC_Scene.MC_Info.visible = false;
         this.FHeadbitmapVect = new Vector.<Bitmap>(TAB_COUNT + BEFORE_COUNT);
         _loc2_ = 0;
         while(_loc2_ < BEFORE_COUNT + TAB_COUNT)
         {
            _loc4_ = FMC_Scene["MC_Player" + _loc2_];
            _loc4_.addEventListener(MouseEvent.MOUSE_MOVE,this.ProcessorOnHeroOver);
            _loc4_.addEventListener(MouseEvent.ROLL_OUT,this.ProcessorOnHeroOut);
            this.FHeadbitmapVect[_loc2_] = new Bitmap();
            _loc2_++;
         }
         this.FUIPage.ButtonPrevious.Substrate = FMC_Scene.MC_Page.MC_PageLeft;
         this.FUIPage.ButtonNext.Substrate = FMC_Scene.MC_Page.MC_PageRight;
         this.FUIPage.LabelPage = FMC_Scene.MC_Page.TF_Page;
         this.FUIPage.TotalQuantity = this.FTotalPage;
         this.FUIPage.PageSize = TAB_COUNT;
         this.FUIPage.PageIndex = 0;
         this.FCurPage = 0;
         this.FUIPage.OnChangePage = this.ProcessorPageOnChange;
         this.FHeadBitmap = new Bitmap();
         FMC_Scene["MC_Player0"]["MC_Icon"].addChild(this.FHeadBitmap);
         this.FTF_Manifesto = FMC_Scene.MC_Info.TF_Desc;
         this.FTF_Manifesto.maxChars = 20;
         TGameUtil.setButtonMode(FMC_Scene.BTN_Alter,true);
         FMC_Scene.BTN_Alter.addEventListener(MouseEvent.CLICK,this.ProcessorOnAlterUp);
         FMC_Scene.MC_Info.BTN_Close.addEventListener(MouseEvent.CLICK,this.ProcessorOnCloseAlter);
         TGameUtil.setButtonMode(FMC_Scene.MC_Info.BTN_Apply,true);
         FMC_Scene.MC_Info.BTN_Apply.addEventListener(MouseEvent.CLICK,this.ProcessorOnApplyUp);
         FMC_Scene.BTN_Close.addEventListener(MouseEvent.CLICK,this.OnCloseMain);
         FMC_Scene.BTN_Help.addEventListener(MouseEvent.MOUSE_MOVE,this.ButtonHelpOnOver);
         FMC_Scene.BTN_Help.addEventListener(MouseEvent.ROLL_OUT,this.ButtonHelpOnOut);
         this.FOverlayerHonorPlayer = new TOverlayerHonorPlayer(this.Parent,CONST_MODULES.MODULE_MasterRoad);
         this.FOverlayerHonorPlayer.Visible = false;
         TUtilityUIOverlayer.ResourcesDispatch(this.FOverlayerHonorPlayer);
      }
      
      protected function UpdateTab() : void
      {
         var _loc1_:int = 0;
         var _loc2_:int = 0;
         var _loc3_:MovieClip = null;
         var _loc4_:TConsumeRankInfo = null;
         this.FUIPage.TotalQuantity = Math.max(0,this.FMasterRoad.HonorPlayers.length - BEFORE_COUNT);
         this.FUIPage.Update();
         _loc1_ = 0;
         while(_loc1_ < BEFORE_COUNT)
         {
            _loc3_ = FMC_Scene["MC_Player" + _loc1_];
            if(_loc1_ < this.FMasterRoad.HonorPlayers.length)
            {
               _loc4_ = this.FMasterRoad.HonorPlayers[_loc1_];
               if(_loc3_.TF_Name)
               {
                  _loc3_.TF_Name.text = _loc4_.UserName;
               }
               if(_loc3_.TF_Server)
               {
                  _loc3_.TF_Server.text = _loc4_.ServerName;
               }
               if(_loc3_.TF_Time)
               {
                  _loc3_.TF_Time.text = TUtilityString.Format(new ConsumeFrameCopy(STRING_MASTERROAD.STRING_004).DescribeString,TUtilityDate.FormatDateChineseNew(new Date(STimingCore.GetClientShowTime(_loc4_.Time) * 1000)));
               }
               if(_loc3_.TF_Desc)
               {
                  _loc3_.TF_Desc.text = _loc4_.Desc1;
               }
               if(_loc1_ == 0)
               {
                  TGameUtil.ShowImageByID(TGameUtil.Type_HeadIcon,this.FHeadBitmap,CONST_MODULES.MODULE_MasterRoad,_loc4_.HeroID);
               }
               else
               {
                  TGameUtil.ShowImageByID(TGameUtil.Type_HeadIcon,this.FHeadbitmapVect[_loc1_],CONST_MODULES.MODULE_MasterRoad,_loc4_.HeroID);
               }
            }
            else
            {
               if(_loc3_.TF_Name)
               {
                  _loc3_.TF_Name.text = new ConsumeFrameCopy(STRING_MASTERROAD.STRING_005).DescribeString;
               }
               if(_loc3_.TF_Server)
               {
                  _loc3_.TF_Server.text = "";
               }
               if(_loc3_.TF_Time)
               {
                  _loc3_.TF_Time.text = "";
               }
               if(_loc3_.TF_Desc)
               {
                  _loc3_.TF_Desc.text = "";
               }
            }
            _loc1_++;
         }
         _loc1_ = 28;
         while(_loc1_ < TAB_COUNT + BEFORE_COUNT)
         {
            _loc3_ = FMC_Scene["MC_Player" + _loc1_];
            _loc2_ = _loc1_ + this.FCurPage * TAB_COUNT;
            if(_loc2_ < this.FMasterRoad.HonorPlayers.length)
            {
               _loc3_.visible = true;
               _loc4_ = this.FMasterRoad.HonorPlayers[_loc2_];
               _loc3_.TF_Name.text = _loc4_.UserName;
            }
            else
            {
               _loc3_.visible = false;
            }
            _loc1_++;
         }
         if(this.FMasterRoad.TempleIndex >= 0 && this.FMasterRoad.TempleStatus == 0)
         {
            FMC_Scene.BTN_Alter.visible = true;
         }
         else
         {
            FMC_Scene.BTN_Alter.visible = false;
         }
      }
      
      protected function UpdateHeroIcon() : void
      {
         var _loc1_:int = 0;
         if(this.FMasterRoad.HonorPlayers.length > 0)
         {
            _loc1_ = 0;
            while(_loc1_ < this.FMasterRoad.HonorPlayers.length)
            {
               if(_loc1_ < this.FMasterRoad.HonorPlayers.length)
               {
                  if(_loc1_ == 0)
                  {
                     TGameUtil.ShowImageByID(TGameUtil.Type_HeadIcon,this.FHeadBitmap,CONST_MODULES.MODULE_MasterRoad,this.FMasterRoad.HonorPlayers[0].HeroID);
                  }
                  else
                  {
                     TGameUtil.ShowImageByID(TGameUtil.Type_HeadIcon,this.FHeadbitmapVect[_loc1_],CONST_MODULES.MODULE_MasterRoad,this.FMasterRoad.HonorPlayers[_loc1_].HeroID);
                  }
               }
               _loc1_++;
            }
         }
      }
      
      protected function ProcessorPageOnChange(param1:Object, param2:int) : void
      {
         this.FCurPage = param2;
         this.UpdateTab();
      }
      
      protected function ProcessorOnHeroOver(param1:MouseEvent) : void
      {
         var _loc2_:int = 0;
         _loc2_ = int(String(param1.currentTarget.name).slice(9));
         if(Boolean(this.FMasterRoad) && _loc2_ < this.FMasterRoad.HonorPlayers.length)
         {
            this.FOverlayerHonorPlayer.Context = this.FMasterRoad.HonorPlayers[_loc2_];
            this.FOverlayerHonorPlayer.Render(FUICore.MouseCoordinate);
            this.FOverlayerHonorPlayer.Show();
         }
      }
      
      protected function ProcessorOnHeroOut(param1:MouseEvent) : void
      {
         this.FOverlayerHonorPlayer.Hide();
      }
      
      protected function ProcessorOnAlterUp(param1:MouseEvent) : void
      {
         FMC_Scene.MC_Info.visible = true;
      }
      
      protected function ProcessorOnCloseAlter(param1:MouseEvent) : void
      {
         FMC_Scene.MC_Info.visible = false;
      }
      
      protected function ProcessorOnApplyUp(param1:MouseEvent) : void
      {
         var _loc2_:TPacket = null;
         var _loc3_:ByteArray = null;
         this.FMasterRoad.Manifesto = this.FTF_Manifesto.text;
         if(FOnGetBox != null)
         {
            FOnGetBox(TProcessorMasterRoad.REQ_TYPE_EDIT_INFO,0,0,this.FMasterRoad.Manifesto);
         }
         FMC_Scene.MC_Info.visible = false;
      }
      
      protected function OnCloseMain(param1:MouseEvent) : void
      {
         if(FOnCloseWindow != null)
         {
            FOnCloseWindow(this);
         }
      }
      
      protected function ButtonHelpOnOver(param1:MouseEvent) : void
      {
         var _loc2_:TSystemLanguage = null;
         if(OnHelpOver != null)
         {
            _loc2_ = SResourcesCore.ResourceBin.GetDatebase(CONST_DATEBASEVO.RESOURCEID_SystemLanguage,CONST_SYSTEMLANGUAGE.HELPTIPS_70170108) as TSystemLanguage;
            this.FHelpTips.Content = _loc2_.Desc;
            OnHelpOver(this,this.FHelpTips);
         }
      }
      
      protected function ButtonHelpOnOut(param1:MouseEvent) : void
      {
         if(OnHelpOut != null)
         {
            OnHelpOut(this);
         }
      }
      
      override public function LogicsPerform() : void
      {
         var _loc1_:int = 0;
         if(FInitialized && this.visible && FMC_Scene.visible)
         {
            this.UpdateHeroIcon();
         }
      }
      
      public function UpdateWindow() : void
      {
         this.UpdateTab();
      }
      
      override public function Unmount() : void
      {
      }
   }
}

