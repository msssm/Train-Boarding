% plot current situation

if plotting_mode == plotDEFAULT
    if(mod(t,10) == 0)
        t
    end
else
    figure(my_figure);
    if plotting_mode == plotMAPview
        clf

        img_scale_factor = 10;

        axis(img_scale_factor*[border(1), border(1)+border(3), border(2), border(2)+border(4)]);
        axis equal;
        hold on;

        rgb = imread('Train_EC.jpg');
        %image(150,300,rgb);
        for itrain = 1:traincount
            xtrain = obstacle(itrain, obstacleXCENTER) - obstacle(itrain, obstacleWIDTH)/2;
            ytrain = obstacle(itrain, obstacleYCENTER) - obstacle(itrain, obstacleHEIGHT)/2;

            % shift dots outside of the train image
            if traincount == 2
                if itrain == 1
                    y_offshift = 5;
                else
                    y_offshift = -5;
                end
            else
                y_offshift = 5;
            end
            
            image(img_scale_factor*(xtrain), img_scale_factor*(ytrain),rgb);
            
            for a = 1:60
                for b = 1:2
                    if(trainseats(itrain,a,b) >= 4) 
                        plot(img_scale_factor*( xtrain + 150/60 * (a-0.5)), img_scale_factor*( y_offshift + ytrain - 2 + 3*b), 'sr');
                    elseif(trainseats(itrain,a,b) == 3) 
                        plot(img_scale_factor*( xtrain + 150/60 * (a-0.5)), img_scale_factor*( y_offshift + ytrain - 2 + 3*b), 'sm');
                    elseif(trainseats(itrain,a,b) == 2) 
                        plot(img_scale_factor*( xtrain + 150/60 * (a-0.5)), img_scale_factor*( y_offshift + ytrain - 2 + 3*b), 'sy');
                    elseif(trainseats(itrain,a,b) == 1) 
                        plot(img_scale_factor*( xtrain + 150/60 * (a-0.5)), img_scale_factor*( y_offshift + ytrain - 2 + 3*b), 'sc');
                    else
                        plot(img_scale_factor*( xtrain + 150/60 * (a-0.5)), img_scale_factor*( y_offshift + ytrain - 2 + 3*b), 'sg');
                    end
                end
            end
        end

        % plot the moving agents (red color = no group, blue color = some
        % group)
        plot(img_scale_factor*agent(((agent(:,agentSTATE)==agentSTATEmoving) & (agent(:,agentGROUP)==agentGROUPnone)),agentXPOS), ...
            img_scale_factor*agent(((agent(:,agentSTATE)==agentSTATEmoving) & (agent(:,agentGROUP)==agentGROUPnone)),agentYPOS), ...
            'r.')
        plot(img_scale_factor*agent(((agent(:,agentSTATE)==agentSTATEmoving) & (agent(:,agentGROUP)~=agentGROUPnone)),agentXPOS), ...
            img_scale_factor*agent(((agent(:,agentSTATE)==agentSTATEmoving) & (agent(:,agentGROUP)~=agentGROUPnone)),agentYPOS), ...
            'm.')

        plot(img_scale_factor*door(door(:,doorSTATE)>10*dt,doorXPOS), 10*door(door(:,doorSTATE)>10*dt,doorYPOS), 'xr')
        plot(img_scale_factor*door(door(:,doorSTATE)<10*dt,doorXPOS), 10*door(door(:,doorSTATE)<10*dt,doorYPOS), 'og')

        for iobstacle = (traincount+1):obstaclecount
            rect(1,:) = [obstacle(iobstacle,obstacleXCENTER) - obstacle(iobstacle,obstacleWIDTH)/2 , obstacle(iobstacle,obstacleYCENTER) - obstacle(iobstacle,obstacleHEIGHT)/2];
            rect(2,:) = [obstacle(iobstacle,obstacleXCENTER) - obstacle(iobstacle,obstacleWIDTH)/2 , obstacle(iobstacle,obstacleYCENTER) + obstacle(iobstacle,obstacleHEIGHT)/2];
            rect(3,:) = [obstacle(iobstacle,obstacleXCENTER) + obstacle(iobstacle,obstacleWIDTH)/2 , obstacle(iobstacle,obstacleYCENTER) + obstacle(iobstacle,obstacleHEIGHT)/2];
            rect(4,:) = [obstacle(iobstacle,obstacleXCENTER) + obstacle(iobstacle,obstacleWIDTH)/2 , obstacle(iobstacle,obstacleYCENTER) - obstacle(iobstacle,obstacleHEIGHT)/2];
            rect(5,:) = [obstacle(iobstacle,obstacleXCENTER) - obstacle(iobstacle,obstacleWIDTH)/2 , obstacle(iobstacle,obstacleYCENTER) - obstacle(iobstacle,obstacleHEIGHT)/2];
            if (obstacle(iobstacle,obstacleSTART) <= t) && (obstacle(iobstacle,obstacleEND) >= t)
                plot(img_scale_factor*rect(:,1),img_scale_factor*rect(:,2), 'k-');
            else
                plot(img_scale_factor*rect(:,1),img_scale_factor*rect(:,2), 'k.:');
            end
        end

        %plot(obstacle(obstacle(:,obstacleACTIVE)==1,obstacleXCENTER), ...
         %   obstacle(obstacle(:,obstacleACTIVE)==1,obstacleYCENTER), 'bs')

        text(img_scale_factor*(border(1)+1),img_scale_factor*(border(2)+1),num2str(t));

    end

    if plotting_mode == plotGRAPHview
        clf

        plot_saved_data

    end
end